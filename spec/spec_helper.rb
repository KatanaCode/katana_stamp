require "katana_stamp"
require "active_support"
require "fileutils"

def clear_files
  Dir.glob('spec/templates/**/*.rb') do |path|
    new_path = path.gsub(/spec\/templates\//, '')
    FileUtils.cp(path, new_path)
  end
end

def run_with_options(options = {})
  options[:exclude_paths] ||= []
  # we don't want to stamp files from this Gem's libraries
  # each time we test
  options[:exclude_paths] << "lib/katana_stamp.rb"
  options[:exclude_paths] << "lib/katana_stamp/*.rb"
  KatanaStamp.run!(options)
end