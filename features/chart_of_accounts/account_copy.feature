Feature: KFS Fiscal Officer Account Copy

  [smoke] As a KFS Fiscal Officer I want to copy an Account
          because I want quickly create many accounts.
  [KFSQA-838] The proper routing of a copied C&G Account with Cornell specific attributes. 
              We are testing that any non-super user perform. This is a smoke test of 
              Cornell-specific attributes in a copied document. We are testing the proper 
              routing of the Cornell specific attributes in a copied document. 

  @smoke @hare
  Scenario: Copy an Account
    Given I am logged in as a KFS Fiscal Officer
    And   I access Account Lookup
    And   I search for all accounts
    And   I copy an Account
    Then  the Account Maintenance Document saves with no errors

  @KFSQA-838 @smoke @wip
  Scenario: Copy C&G Account (Smoke Test)
    Given I am logged in as a KFS User
    When  I start to copy a C&G Account
    Then  all default fields are filled in for the new Account
    When  I fill in the missing required fields for the new Account
    And   I fill in the missing Cornell-specific fields for the new Account
    And   I submit the Account document
    Then  the Account document goes to ENROUTE
    And   the Account document routes successfully through this route:
      | Role                       | Action  |
      | KFS-SYS Fiscal Officer     | APPROVE |
      | KFS-SYS C&G Processor      | APPROVE |
      | KFS-SYS Sub Fund Reviewer  | APPROVE |
      | KFS-SYS Account Supervisor | APPROVE |
#    And   the next pending action for the Account document is an APPROVE from a KFS-SYS Fiscal Officer
#    When  I switch to the user with the next Pending Action in the Route Log for the Account document
#    And   I approve the Account document
#    Then  The document should have no errors
#    And   the next pending action for the Account document is an APPROVE from a KFS-SYS C&G Processor
#    When  I switch to the user with the next Pending Action in the Route Log for the Account document
#    And   I approve the Account document
#    Then  The document should have no errors
#    And   the next pending action for the Account document is an APPROVE from a KFS-SYS Sub Fund Reviewer
#    When  I switch to the user with the next Pending Action in the Route Log for the Account document
#    And   I approve the Account document
#    Then  The document should have no errors
#    And   the next pending action for the Account document is an APPROVE from a KFS-SYS Account Supervisor
#    When  I switch to the user with the next Pending Action in the Route Log for the Account document
#    And   I approve the Account document
#    Then  The document should have no errors
    And   the Account document goes to FINAL
