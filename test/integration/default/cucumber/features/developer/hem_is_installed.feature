Feature: Hem is installed
  In order to have a known ruby installation without having to compile it
  As a developer
  I would like the tool hem to be installed

Background:
  Given I have provisioned the server

Scenario: Hem is installed
  When I execute "hem -v"
  Then I will get an exit code of 0

Scenario: Hem lists commands without errors
  When I execute "hem"
  Then I will see a list of commands
