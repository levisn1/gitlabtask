class User
  attr_reader :username, :home_directory
  def initialize(username, home)
    @username = username
    @home_directory = home
  end
end

unix_users = []
File.open('/etc/passwd').readlines.each do |line|
  split = line.split(':')
  unix_users << User.new(split[0], split[5])
end

file = File.open("/var/log/linux_users.txt", "w")
unix_users.each do |user|
  file.puts "#{user.username}:#{user.home_directory}"
end
file.close
