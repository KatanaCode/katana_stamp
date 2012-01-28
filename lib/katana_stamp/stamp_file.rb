module KatanaStamp
  class StampFile

    def initialize(path, options)
      @comment_delimiter = options[:comment_delimiter] || '#'
      @year = options[:year] || Time.now.year
      @owner = options[:owner] || 'Katana Code Ltd'
      @path = path
      @options_message = options[:message]
    end

    # Path to this file
    attr_reader :path
    
    # Comment delimeter used in stamp (defaults to '#')
    attr_reader :comment_delimiter
    
    # Copyright year (defaults to this Year)
    attr_reader :year
    
    # Copyright owner (defaults to Katana Code Ltd)
    attr_reader :owner

    # ANSI Colour code numbers
    ANSI_COLORS = {
      red: 31,
      green: 32,    
      yellow: 33,
    }

    # When called, will add a copyright notice comment to the end of the file
    # with path
    def stamp!
      case 
      when has_stamp_with_another_owner?
        print_colour("stamped by another owner!", :red, :warn)
      when has_stamp?
        print_colour("already stamped!", :yellow)
      else
        `echo "#{"\n" unless has_closing_break?}#{message}" >> #{path}`
        print_colour("stamped!", :green)        
      end
    end

    # Does the file already have a copyright stamp?
    def existing_stamp
      @existing_stamp = begin
        File.open(path, "r") do |file|
          file.read.scan(%r{#{comment_delimiter}\s\(c\)(.+)\sAll\sRights\sReserved}).flatten.first
        end
      end
    end

    # The existing Copyright owner or nil
    def existing_owner
      existing_stamp.scan(%r{Copyright\s#{year}\s(.+)\.}).flatten.first
    end

    # Does this file already have a stamp?
    def has_stamp?
      !!existing_stamp
    end
    
    # Regular expression to match stamps
    def stamp_regexp
      %r{#{comment_delimiter}\s\(c\)(.+)\sAll\sRights\sReserved}
    end

    # Does this file have a stamp with a different owner?
    def has_stamp_with_another_owner?
      has_stamp? and existing_owner != owner
    end

    # The message to be stamped to each file
    def message
      @message ||= begin
        message_prefix = "#{comment_delimiter} (c) "
        if @options_message
          message_prefix << @options_message
        else
          message_prefix << "Copyright #{year} #{owner}. All Rights Reserved"
        end
        message_prefix
      end
    end

    private

    # Print a message to the console with colour
    def print_colour(msg, colour, method = :puts)
      colour_id = ANSI_COLORS[colour] || 39
      send(method, "\033[0;#{colour_id}m#{path} #{msg}\033[0m")
    end

    # Does this file have a line break at the end?
    def has_closing_break?
      last_char == "\n"
    end

    # The last character of this file
    def last_char
      last_line[-1] if last_line
    end

    # The last line of this file
    def last_line
      IO.readlines(path)[-1]
    end

  end  
end