Given(/^I have provisioned the server$/) do
end

Given(/^Hem is installed$/) do
end

Given(/^I have set up hem to run in local mode$/) do
end

When(/^I execute "([^"]*)" as the "([^"]*)" user I will see "([^"]*)"$/) do |command, user, expected|
  require 'shellwords'
  command = Shellwords.escape(command)
  user = Shellwords.escape(user)
  full_command = "sudo su - #{user} -c #{command}"
  expect(`#{full_command}`).to match(expected)
end

When(/^I execute "([^"]*)" as the "([^"]*)" user I should see "([^"]*)" being "([^"]*)"$/) do |command, user, variable, value|
  require 'shellwords'
  command = Shellwords.escape(command)
  user = Shellwords.escape(user)
  full_command = "sudo su - #{user} -c #{command}"
  expect(`#{full_command}`).to match("#{variable}=#{value}")
end
