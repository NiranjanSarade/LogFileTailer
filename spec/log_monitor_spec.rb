require File.dirname(__FILE__) + '/spec_helper'

describe "Log Monitor" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
    last_response.body.should == "This is the Log File Monitor page."
  end

  it "should return the correct content-type when viewing root" do
    get '/'
    last_response.headers["Content-Type"].should == "text/html"
  end

  it "should return 404 when page cannot be found" do
    get '/404'
    last_response.status.should == 404
  end
  
  it "should return appropriate response according to the log file modification in last 2 hours to /healthcheck" do
    get '/healthcheck'
    last_response.body.should =~ /The Log file was last modified on/
  end

  it "should return the last 15 lines in the log file by default to /tail" do
    get '/tail'
    last_response.body.should =~ /10547 rows processed./
  end

  it "should return last n lines in the log file to /tail/n" do
    get '/tail/1'
    last_response.body.should =~ /13:43:44 93 Status: Exiting.  This will take a while./
    last_response.body.should_not =~ /13:43:41  Status: Table NOT found!/
  end

end