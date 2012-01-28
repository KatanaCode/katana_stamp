require "katana_stamp"
require "active_support"
require "fileutils"

def clear_files
  Dir.glob('spec/templates/**/*.rb') do |path|
    new_path = path.gsub(/spec\/templates\//, '')
    FileUtils.cp(path, new_path)
  end
end