module KatanaStamp
  class StampFile < Struct.new(:path, :options)

    # The default message stamped to each file.
    # The %s are placeholders for _year_ and _owner_ respectively
    COPYRIGHT_NOTICE = "(c) Copyright %s %s. All Rights Reserved."
    
    # When called, will add a copyright notice comment to the end of the file
    # with path
    def stamp
      `echo "#{"\n" unless has_closing_break?}# #{message}" >> #{path}`
    end

    # Does the file already have a copyright stamp?
    def has_stamp?
      File.open(path, "r") { |file| file.read.scan(message).any? }
    end
    
    # The message to be stamped to each file
    # defaults to: COPYRIGHT_NOTICE
    def message
      options[:year]  ||= Time.now.year
      options[:owner] ||= 'Katana Code Ltd'      
      message = options[:message] || COPYRIGHT_NOTICE % [options[:year], options[:owner]]
    end
    
    private
    

    def has_closing_break?
      last_char == "\n"
    end

    def last_char
      last_line[-1] if last_line
    end

    def last_line
      IO.readlines(path)[-1]
    end

  end  
end