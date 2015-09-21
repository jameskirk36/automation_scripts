require 'net/ssh'

host = ENV["TARGET_MACHINE"]
username = ENV["USERNAME"]
password = ENV["PASSWORD"] 
command = ARGV[0]

puts "#{username}@#{host}"

def ssh_exec!(ssh, command)
  stdout_data = ""
  stderr_data = ""
  exit_code = nil
  exit_signal = nil
  ssh.open_channel do |channel|
    channel.exec(command) do |ch, success|
      unless success
        abort "FAILED: couldn't execute command (ssh.channel.exec)"
      end

      channel.on_data do |ch,data|
        stdout_data+=data
      end
  
      channel.on_extended_data do |ch,type,data|
        stderr_data+=data
      end
  
      channel.on_request("exit-status") do |ch,data|
        exit_code = data.read_long
      end
  
      channel.on_request("exit-signal") do |ch, data|
        exit_signal = data.read_long
      end
    end
  end
  ssh.loop
  return stdout_data, stderr_data, exit_code, exit_signal
end

Net::SSH.start(host, username, password: password)  do |ssh|
  puts "running command: #{command}"
  stdout_data, stderr_data, exit_code, exit_signal = ssh_exec!(ssh, command) 
  unless stderr_data.empty?
    puts stderr_data
  end
  unless stdout_data.empty?
    puts stdout_data
  end
  puts "command finished with exit code #{exit_code}"
  exit(exit_code)
end
