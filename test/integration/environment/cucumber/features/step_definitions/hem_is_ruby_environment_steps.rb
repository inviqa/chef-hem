Given(/^I have provisioned the server$/) do
end

Given(/^Hem is installed$/) do
end

Given(/^I have set up hem to run in local mode$/) do
end

When(/^I execute "([^"]*)" as the "([^"]*)" user I will see "([^"]*)"$/) do |arg1, arg2, arg3|
  require 'shellwords'
  command = Shellwords.escape(arg1)
  user = Shellwords.escape(arg2)
  full_command = "sudo su - #{user} -c #{command}"
  @output = `#{full_command}`
  expect(@output).to match(arg3)
end

When(/^I execute "([^"]*)" as the "([^"]*)" user I should see "([^"]*)" being "([^"]*)"$/) do |arg1, arg2, arg3, arg4|
  require 'shellwords'
  command = Shellwords.escape(arg1)
  user = Shellwords.escape(arg2)
  full_command = "sudo su - #{user} -c #{command}"
  @output = `#{full_command}`
  expect(@output).to match("#{arg3}=#{arg4}")
end
