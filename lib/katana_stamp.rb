module KatanaStamp

  class CustomFile < Struct.new(:path, :options)
    
    COPYRIGHT_NOTICE = "(c) Copyright %s %s. All Rights Reserved."

    def stamp
      `echo "#{"\n" unless has_closing_break?}# #{message}" >> #{path}`
    end
    
    def message
      options[:year]  ||= Time.now.year
      options[:owner] ||= 'Katana Code Ltd'      
      message = options[:message] || COPYRIGHT_NOTICE % [options[:year], options[:owner]]
    end

    def has_stamp?
      File.open(path, "r") { |file| file.read.scan(message).any? }
    end

    def has_closing_break?
      last_char == "\n"
    end

    private

    def last_char
      last_line[-1] if last_line
    end

    def last_line
      IO.readlines(path)[-1]
    end

  end

  DIRS = %W{ app/**/*.rb lib/**/*.rb }

  def run!(options={})
    options[:exclude_paths] ||= []
    options[:include_paths].each do |path|
      DIRS << path
    end if options[:include_paths]
    
    DIRS.each do |main_dir|
      Dir.glob("#{main_dir}").each do |path|
        next if options[:exclude_paths].detect { |pattern| File.fnmatch(pattern, path) }
        custom_file = CustomFile.new(path, options)
        custom_file.stamp unless custom_file.has_stamp?
      end      
    end
  end

  module_function :run!

end
# (c) Copyright 2012 Katana Code Ltd. All Rights Reserved.
# (c) Copyright 2012 Bodacious. All Rights Reserved.
# (c) Copyright 1999 Katana Code Ltd. All Rights Reserved.
# Released under the Bodacious license
