require 'thor'
require_relative 'lib/command_runner'
require_relative 'lib/change_monitor'

class HolyGit < Thor
  desc "commit changes", "commits changes if all rspec tests are passing"
  def git_hits_the_fan
    puts "Checking if files have been modified...."
    if ChangeMonitor.pwd_file_changes?
      puts "File changes detected"
      CommandRunner.run_tests(Dir.pwd) unless ChangeMonitor.has_failing_test?
    else
      puts "No file changes. Get back to work!"
    end
  end
end

HolyGit.start(ARGV)
