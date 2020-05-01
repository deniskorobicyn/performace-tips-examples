require 'digest'

# usuing envs as it's faster then parsing ARGV
DIR_A = ENV['DIR_A']
DIR_B = ENV['DIR_B']
OUTPUT = ENV['OUTPUT']


$md5hashes = Set.new
$filename_map_dir_a = {}

def traverse_dir(dir_path)
  Dir.entries(dir_path).each do |filename|
    filepath = "#{dir_path}/#{filename}"
    next if File.directory?(filepath)
  
    file_hash = Digest::MD5.hexdigest(IO.read(filepath)) # tthis should be precalculated on big scale folders
    yield filename, file_hash
  end
end

def output(file_name, file_hash)
  if OUTPUT == 'q'
    "#{$filename_map_dir_a[file_hash]} #{file_name}"
  else
    "#{$filename_map_dir_a[file_hash]} from #{DIR_A} is the same as #{file_name} in #{DIR_B}"
  end
end

traverse_dir(DIR_A) do |file_name, file_hash|
  $md5hashes << file_hash
  $filename_map_dir_a[file_hash] = file_name
end

traverse_dir(DIR_B) do |file_name, file_hash|
  if $md5hashes.include?(file_hash)
    $stdout.print output(file_name, file_hash)
    $stdout.puts
  end
end
