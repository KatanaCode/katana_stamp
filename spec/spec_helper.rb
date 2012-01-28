require "katana_stamp"

require "active_support"

def clear_files
  Dir.glob('**/test_*.rb').each do |path|
    File.open(path, 'r+') do |file|
      path = path.split('/').last.gsub(/\.rb/, '')        
      file.write <<-EOF
class #{ActiveSupport::Inflector.camelize(path, true)}

end
      EOF
    end
  end
end