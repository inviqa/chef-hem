Feature: Hem is configured as the ruby environment
  In order to have a known ruby installation without having to compile it
  As a developer
  I would like hem's ruby installation to be the default ruby install

Background:
  Given I have provisioned the server
  And Hem is installed

Scenario: Hem is the default ruby environment for the current user
  When I execute "which ruby" as the "kitchen" user I will see "/opt/hem/embedded/bin/ruby"

Scenario: Hem is the default ruby environment for all users
  When I execute "which ruby" as the "root" user I will see "/opt/hem/embedded/bin/ruby"

Scenario: Hem is set to execute in local mode for all users
  Given I have set up hem to run in local mode
  When I execute "printenv" as the "root" user I should see "HEM_RUN_ENV" being "local"
