require "katana_stamp"
require "active_support"

def copy_template_files
  FileUtils.cp_r(Dir.glob("#{File.dirname(__FILE__)}/templates/*"), ".")
end

def run_with_options(options = {})
  options[:exclude_paths] ||= []
  # we don't want to stamp files from this Gem's libraries
  # each time we test
  options[:exclude_paths] << "lib/katana_stamp.rb"
  options[:exclude_paths] << "lib/katana_stamp/*.rb"
  KatanaStamp.run!(options)
end