require 'file/tail'

class LogFileTailer
  
  attr_accessor :path_to_file
  
  def initialize(options={})
    @path_to_file = File.join(File.dirname(__FILE__), "sample_logs.txt")
  end
  
  def is_log_file_updated_in_last_2_hours?(hours = 2)
    (Time.now - File.mtime(@path_to_file)) < (hours * 60 * 60) ? "Yes" : "No"
    
  end

  def tail_log(lines = 20)
    File.open(@path_to_file) do |log|
      log.extend(File::Tail)
      log.return_if_eof = true
      log.backward(lines)
      log.tail.collect { |line| line  }
    end
  end
  
end


      

