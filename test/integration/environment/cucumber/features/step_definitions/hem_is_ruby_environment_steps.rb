Given(/^I have provisioned the server$/) do
end

Given(/^Hem is installed$/) do
end

Given(/^I have set up hem to run in local mode$/) do
end

When(/^I execute "([^"]*)" as the "([^"]*)" user I will see "([^"]*)"$/) do |cmd, user, expected|
  full_command = command_as_user(cmd, user)
  expect(`#{full_command}`).to match(expected)
end

When(/^I execute "([^"]*)" as the "([^"]*)" user I should see "([^"]*)" being "([^"]*)"$/) do |cmd, user, var, value|
  full_command = command_as_user(cmd, user)
  expect(`#{full_command}`).to match("#{var}=#{value}")
end

def command_as_user(command, user)
  require 'shellwords'
  command = Shellwords.escape(command)
  user = Shellwords.escape(user)
  "sudo su - #{user} -c #{command}"
end
