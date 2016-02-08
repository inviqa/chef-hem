Given(/^I have provisioned the server$/) do
end

When(/^I execute "([^"]*)"$/) do |command|
  @output = `sudo su - -c '#{command}'`
end

Then(/^I will get an exit code of (\d+)$/) do |exit_code|
  expect($CHILD_STATUS.to_i).to eq(exit_code.to_i)
end

Then(/^I will not get an exit code of (\d+)$/) do |exit_code|
  expect($CHILD_STATUS.to_i).to_not eq(exit_code.to_i)
end

Then(/^I will see a list of commands$/) do
  expect(@output).to match('Commands:')
end
