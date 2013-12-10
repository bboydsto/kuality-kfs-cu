Feature: Create Account KFSMI-8332

  I want to be notified as a KFS user
  when I leave all fields blank during Create an Account
  because this will help data entry procedures.

#  Background:
#    Given I am backdoored as bla

  Scenario: KFS User does not input in any fields KFSMI-8332
    Given  I am logged in as a KFS user
    When   I Create an Account and leave every field blank
    Then   I should get an error saying I left every field blank