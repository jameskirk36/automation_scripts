require 'net/ssh'

host = ENV["TARGET_MACHINE"]
username = ENV["USERNAME"]
password = ENV["PASSWORD"] 
command = ARGV[0]

class Job
  attr_accessor :stdout
  attr_accessor :stderr
end

job = Job.new
puts "#{username}@#{host}"

Net::SSH.start(host, username, password: password)  do |ssh|
  puts "running command: #{command}"
  job.stdout  = ""
  job.stderr = ""
  ssh.exec! command do |channel, stream, data|
    job.stdout << data if stream == :stdout
    job.stderr << data if stream == :stderr
  end
end
puts "stderr:"
puts job.stderr
puts "stdout:"
puts job.stdout
