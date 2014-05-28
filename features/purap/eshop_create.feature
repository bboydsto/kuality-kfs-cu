Feature: PURAP e-SHOP Create

  [KFSQA-732] PURAP E2E REQS - Create -- e-SHOP (PURAP E2E-001b) - e-SHOP is shopper

  @KFSQA-732 @purap @cornell @wip
  Scenario: PURAP E2E e-SHOP shopper test
    Given I login as an e-SHOP Buyer
    And   I visit the "e-SHOP" page
    And   I select a e-SHOP Hosted Supplier
    When  I search for an item with the following qualifications:
      | Minimum Price            | 1500  |
      | Maximum Price            | 10000 |
      | Is a Sensitive Commodity | true  |
    Then  the e-SHOP item search should return 1 result

    When  I enter a quantity of 40 on the e-SHOP item search result
    And   I add the e-SHOP item search result to my Cart
    And   I view my e-SHOP Cart
    And   I add a note to my e-SHOP Cart
    And   I save my e-SHOP Cart
    And   I assign my e-SHOP Cart to an e-SHOP assignee
    Then  I should be congratulated on a successful e-SHOP Cart assignment

    Given I login as an e-SHOP assignee
    When  I retrieve my e-SHOP Cart
    And   I submit the e-SHOP Cart
    And   I close the Requisition document, saving it if necessary
    And   I logout of KFS and log back in
    And   I view the Requisition document on my action list
    Then  the Account Distribution Method is "Proportional"
    And   the e-SHOP Flags says "No e-Shop flag is set to true"

    When  I calculate my Requisition document
    And   I submit the Requisition document
    Then  the document status is ENROUTE
    And   the Payment Request Positive Approval Required field equals "No"

    Given I use my Action List to route the Requisition document to FINAL by clicking approve for each request
    When  I view the Purchase Order document
    Then  the document status is FINAL
    And   the Purchase Order Doc Status is Open

    # PO KFS -> SciQuest
    Given I login as an e-SHOP assignee
    When  I open the Purchase Order document by searching for it in e-SHOP
    Then  the e-SHOP document status is Completed
    And   the Delivery Instructions displayed match what came from the Purchase Order
    And   the Notes to Supplier displayed match what came from the Purchase Order
    And   the Attachments for Supplier match what came from the Purchase Order

    # KFS Batch Processing for PO
    Given I am logged in as a KFS System Administrator
    Then  the Object Codes for the Purchase Order document appear in the document's GLPE entry
    Given Nightly Batch Jobs run
    Then  the Purchase Order document has matching GL and GLPE offsets
    Given I run Auto Close Purchase Orders
    Then  the last Nightly Batch Job should have succeeded
