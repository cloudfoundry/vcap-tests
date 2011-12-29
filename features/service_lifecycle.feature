# Copyright:: Copyright (c) 2011 VMware Inc.
#
@lifecycle @sinatra @ruby @services
Feature: Deploy the sinatra canonical app and test lifecycle APIs

  As a user with all canonical apps.
  I want to deploy all canonical apps and test lifecycle functions.

  Background: deploying canonical service
    Given I have registered and logged in
    Given I have deployed my application named app_sinatra_service

  @mysql @snapshot
  Scenario: Take mysql snapshot and rollback to a certain snapshot
    Given I have my running application named app_sinatra_service
    When I provision mysql service
    Then I check snapshot extension is enabled
    Then I post mysqlabc to mysql service with key abc
    Then I should be able to get from mysql service with key abc, and I should see mysqlabc
    When I create a snapshot of mysql service
    Then I should be able to query snapshots for mysql service
    Then I post mysqlabc2 to mysql service with key abc
    Then I should be able to get from mysql service with key abc, and I should see mysqlabc2
    When I rollback to previous snapshot for mysql service
    Then I should be able to get from mysql service with key abc, and I should see mysqlabc

  @mysql @delete @snapshot
  Scenario: sinatra test delete service
    Then I delete my service

  @mysql @serialized
  Scenario: Import and export serialized data for mysql service
    Given I have my running application named app_sinatra_service
    When I provision mysql service
    Then I post mysqlabc to mysql service with key abc
    Then I should be able to get from mysql service with key abc, and I should see mysqlabc
    When I create a serialized URL of mysql service
    Then I should be able to download data from serialized URL
    Then I post mysqlabc2 to mysql service with key abc
    Then I should be able to get from mysql service with key abc, and I should see mysqlabc2
    When I import serialized data from URL of mysql service
    Then I should be able to get from mysql service with key abc, and I should see mysqlabc
    Then I post mysqlabc2 to mysql service with key abc
    Then I should be able to get from mysql service with key abc, and I should see mysqlabc2
    When I import serialized data from request of mysql service
    Then I should be able to get from mysql service with key abc, and I should see mysqlabc

  @mysql @delete @serialized
  Scenario: sinatra test delete service
    Then I delete my service

  @delete @delete_app
  Scenario: sinatra test delete app
    Given I have my running application named app_sinatra_service
    When I delete my application
    Then it should not be on AppCloud
