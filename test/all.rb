Dir.entries('test/').each { |file|
  puts file
  next if ['.', '..', 'all.rb'].include?(file)
  require_relative file
}
