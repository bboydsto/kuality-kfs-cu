Feature: KFS Fiscal Officer Account Copy

  [smoke] As a KFS Fiscal Officer I want to copy an Account
          because I want quickly create many accounts.

  @smoke @hare
  Scenario: Copy an Account
    Given I am logged in as a KFS Fiscal Officer
    And   I access Account Lookup
    And   I search for all accounts
    And   I copy an Account
    Then  the Account Maintenance Document saves with no errors

  @KFSQA-838 @smoke @wip
  Scenario: Copy C&G Account (Smoke Test)
    Given I am logged in as a non-admin user
    And Go to Account 1258320
    And Copy
    And Select COA Appropriation Number
    And Choose Labor Benefit Rate Category
    .
    .
    .
    And eVerify indicator is "N"
    And Submit
    Then Verify proper routing to FO
    Then Verify Proper Routing to Sub Fund Reviewer
    Then Verify FYI to Acct Super
