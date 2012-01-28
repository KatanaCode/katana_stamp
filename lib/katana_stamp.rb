module KatanaStamp

  require 'katana_stamp/stamp_file'
  
  DIR_PATTERS = [ "app/**/*.rb", "lib/**/*.rb" ]

  # Stamps all files matching DIR_PATTERNS and the +--include-paths+ option unless they have
  # already been stamped
  def run!(options={})
    options[:exclude_paths] ||= []
    options[:include_paths].each do |path|
      DIR_PATTERS << path
    end if options[:include_paths]
    
    DIR_PATTERS.each do |main_dir|
      Dir.glob(main_dir).each do |path|
        next if options[:exclude_paths].detect { |pattern| File.fnmatch(pattern, path) }
        custom_file = StampFile.new(path, options)
        if custom_file.has_stamp?
          print_colour("#{path} already stamped!", :yellow)
        else
          print_colour("#{path} stamped!", :green)
          custom_file.stamp
        end
      end      
    end
    true # return true
  end
  
  def self.print_colour(message, colour)
    colour_id = 
      case colour
      when :yellow then 33
      when :green then 32
      else
        37 # white
      end
    puts "\033[0;#{colour_id}m#{message}\033[0m"
  end
  
  module_function :run!

end