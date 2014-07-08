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

  @KFSQA-838 @cornell @smoke @CG @Copy @Routing @wip
  Scenario: Copy C&G Account (Smoke Test)
    Given I am logged in as a KFS User - ROLE 54
    When I open a C&G account (with existing a CFDA #, Indirect Cost Rate EC0, and Account Indirect Cost Recovery Type Code 22)
    And enter chart
    And enter Account number
    And search
    And select copy
    And The original fields with values, auto populate in new fields. (Caution: This may vary depending on account used.) Likely the following fields will auto populate: Original section: Account Name, Organization Code, Campus Code, Account Effective Date, Account Expiration Date, Account Postal Code, Account City Name, Account State Code, Account Street Address, Account Type Code, Sub-fund Group code, Account Fringe Benefit checked, Higher Ed Function Code, Account Restricted Status Code, Labor Benefit Rate Category Code. Account Responsibility section: Fiscal Officer Principal name, Account Supervisor Principal Name, Account manager Principal Name, Continuation Chart of Accounts Code, Continuation Account Number, Budget Record Level Code, Account Sufficient Funds Code. Guidelines and Purpose section: Account Expense Guideline Text, Account Income Guideline Text, Account Purpose Text. (nothing for account description section) Contract and Grants Section: Contract Control Chart of Accounts Code, Contract Control Account Number, Account Indirect Cost Recovery Type Code, Indirect Cost Rate, CFDA Number, CG Account Responsibility ID, Invoice Frequency Code, Invoice Type Code, and eVerify indicator is no/off. Indirect Cost Recovery Accounts section: Active indicator checked, Indirect Cost Recovery Chart of Accounts Code, Indirect Cost Recovery Account Number, Account Line Percent, Active indicator checked.
    And Verify new attributes and CFDA# persist: Invoice frequency, Invoice type code, eVerify indicator, Cost Share for Project Number
    And enter description
    And Enter Chart code (original section)
    And Enter account number (original section)
    And Enter or keep Appropriation Number (original section)
    And Enter or keep Labor Benefit Rate Category (original section)
    And Enter Major Reporting Category
    And Enter or keep subfung program
    And Enter or keep Continuation Account Number (cannot be an expired or inactive account)
    And enter or keep CFDA # - Verify CFDA # persists (C&G section)
    And eVerify indicator is not checked ( C&G section)
    And change invoice frequency code ( C&G section)
    And change invoice type code ( C&G section)
    And Enter or keep Cost Share for Project Number ( C&G section)
    And Enter new Indirect cost recovery chart of accounts code (IDC Recovery accts section)
    And Enter new Indirect Cost Recovery Account Number
    And Enter Line Percent
    And Active indicator is checked
    And Add new IDC recovery chart of accounts code, IDC recovery account number, and account line percent OR edit existing IDC recovery account line percent(s), so that total percent is 100% for all IDC recovery accounts listed.
    And click add
    And Submit
    And reload
    And Verify new attributes and CFDA# persist: Invoice frequency, Invoice type code, eVerify indicator, Cost Share for Project Number
    And Verify routing to FO
    And Verify routing to Organization Reviewer
    And Verify routing to C&G Processor
    And Verify routing to Sub-Fund reviewer
    And Verify FYI to Account Supervisor
    Then edoc goes to Final
    And as KFS User - ROLE 54
    And enter Distribution of Income and Expense
    And enter a description
    And enter an account number, object code 6540 and an amount on the from line
    And click add
    And enter the new account number, object code 6540 and an amount on the to line
    And click add
    And submit
    And process all approvals through to final status
    And Run nightly job
    And validate new account has transactions (should be amount of transaction (times) percent that is assigned to the Account Indirect Cost Recovery Account Type Code.) Likely object code 9070 or 9080.
    Then validate recovery accounts have income transactions posted (should be amount of transaction above (so original expense times type code percent) (times) percent noted on account line percent of each recovery account.)
