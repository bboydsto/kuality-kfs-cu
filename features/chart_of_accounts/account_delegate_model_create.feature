Feature: Account Delegate Model Create

  [KFSQA-1009] 1) Create an account delegate model where multiple document type names are entered,
                  setting various dollar limit values for single doc type name, and attempting
                  to set two delegates for the same doc type name and delegate.
               2) This tests the functionality of creating account delegates using existing model,
                  and that invalid values for chart and org code cannot be used.
               3) Use REQS base function to test delegate limits

  @KFSQA-573 @AcctDelegate @KFSPTS-991 @sloth
  Scenario: Create an Account Global Model eDoc with an Invalid Organization Code
    Given I am logged in as a KFS Chart Manager
    When  I submit an Account Delegate Model document with an invalid Organization Code
    Then  I should get an error saying "The specified Organization Code does not exist."

  @KFSQA-1009 @smoke @wip
  Scenario: Create Account Delegate Model eDoc
    Given I am logged on as an account delegate global initiator (cu), role 100000187
    When  I create an account delegate model
    And enter chart of accounts code
    And enter organization code
    And enter account delegate model name
    And active indicator is checked (default)
    And enter document type name
    And check account delegate primary route
    And accept account delegate start date default (current date)
    And enter approval to amount
    And enter account delegate principal name
    And active indicator is checked (default)
    And click add
    And enter same document type name as above
    And check account delegate primary route
    And accept account delegate start date default (current date)
    And enter approval from this amount
    And enter approval to amount
    And enter account delegate principal name
    And active indicator is checked (default)
    And click add
    Then receive error " A primary route for this specific document type already exists on this global document. You must remove that Delegation before you can add this one."
    And deselect account delegate primary route
    And click add
    And enter same document type name as above
    And do not check account delegate primary route
    And accept account delegate start date default (current date)
    And enter approval to amount
    And enter account delegate principal name using one from prior two delegations
    And active indicator is checked (default)
    And click add
    Then receive error " Duplicate entries in (GDLM) are not allowed."
    And enter new account delegate principal name
    And click add
    And enter different document type name
    And check account delegate primary route
    And accept account delegate start date default (current date)
    And enter approval to amount
    And enter account delegate principal name
    And active indicator is checked (default)
    And click add
    And click submit
    And click reload (give few seconds to update first)
    And document should be in "final" status


  @KFSQA-1009 @smoke @wip
  Scenario: Create Account Delegate Global from Model
    Given I am logged on as an account delegate global initiator (cu), role 100000187
    When open account delegate global from model
    And enter chart of accounts code
    And enter organization code
    And enter account delegate model name
    And search
    And select account delegate model name from earlier test And return value
    And enter description
    And in new account section of existing model, select chart
    And enter account number tied to accounts and delegate principal names in first test
    And Select multiple accounts using the Look Up/Add Multiple Account Global Search Lines:
    And enter invalid chart code
    And search
    And No results are found
    And enter valid chart code
    And enter invalid org code
    And search
    And No results are found
    And enter valid org code tied to accounts and delegate principal names in first test
    And search And select all
    And return selected
    And Select multiple accounts using the Look Up/Add Multiple Account Global Search Lines:
    And enter chart
    And enter fiscal officer principal name tied to accounts And delegate principal names in first test
    And search And select all
    And return selected
    And click submit
    And click reload (give few seconds to update first)
    And document should be in "final" status

  @KFSQA-1009 @smoke @wip
  Scenario: Create req for account within delegate's limits and test doc is routed to correct delegate.
    Given GIVEN I INITIATE A REQS
    When account belongs to delegate tied to earlier tests
    And req limit is within delegate's limits
    And req is submitted
    Then req is routed to correct delegate for limit