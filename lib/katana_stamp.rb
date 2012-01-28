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
        custom_file.stamp unless custom_file.has_stamp?
      end      
    end
  end

  module_function :run!

end