Feature: PURAP e-SHOP Create

  [KFSQA-732] PURAP E2E REQS - Create -- e-SHOP (PURAP E2E-001b) - e-SHOP is shopper

  @KFSQA-732 @purap @cornell
  Scenario: PURAP E2E e-SHOP shopper test
    Given I login as an e-SHOP shopper
    And   I go to the e-SHOP main page
    When  I select a Hosted Vendor
    And   I add a random Sensitive Commodity item with a total between $1500 and $10000 to my Cart
    And   I view my Cart
    And   I add a Note for Justification
    And   I assign the Cart to "spp7" as the eShop Buyer
    Then  the Successful Cart Assignment page is displayed

    Given I am logged in as "spp7"
    And
  Verify correct routing (should route through Fiscal Officer, Contract & Grants and Commodity)
  Doc Status = Final
  Reload
  Verify "Payment Request Positive Approved" = "Yes"
  Validate eShop flag = "True"
