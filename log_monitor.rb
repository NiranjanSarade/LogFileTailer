require 'log_file_tailer'

before do
  @log_file = LogFileTailer.new
end

get '/' do
  [200, {"Content-Type" => "text/html"}, "This is the Log File Monitor page."]
end

# Used to check if the log file was modified in the last 2 hours
get '/healthcheck' do
  @health_check = @log_file.is_log_file_updated_in_last_2_hours?
  @last_modified = File.mtime(@log_file.path_to_file)
  [200, {"Content-Type" => "text/html"},
    "The Log file was last modified on: #{@last_modified}. Was this during the last 2 hours? = #{@health_check}"]
end

# By default shows the last 15 lines of the log file
get '/tail' do 
  @last_modified = File.mtime(@log_file.path_to_file)
  @show_lines = @log_file.tail_log(15)
  erb :index
end

#number of lines of the log you want to see for example: localhost:9292/tail/30 shows the last 30 lines
get '/tail/:lines' do 
  lines = params[:lines].to_i
  @last_modified = File.mtime(@log_file.path_to_file)
  @show_lines = @log_file.tail_log(lines)
  erb :index
end

enable :inline_templates

__END__

@@ index
<html>
  <head>
  </head>
<body>
<h1>The Log File was last updated at <%= @last_modified %></h1>
  <% @show_lines.each do |line| %>
    <p><%= line %></p>
  <% end %>
</body>
</html>
