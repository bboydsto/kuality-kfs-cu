Feature: Pre-Encumbrance

  [KFSQA-654] Open Encumbrances Lookup not displaying pending entries generated from the PE eDoc.
  [KFSQA-739] Background: Cornell University needs to process pre-encumbrances with expense object
              codes and verify the Accounting Line persists to the GL
  [KFSQA-664] Cornell has modified KFS to allow for revenue object codes on the PE form. Allow revenue on Pre-Encumbrance.

  @KFSQA-654
  Scenario: Open Encumbrances Lookup will display pending entries from PE eDoc
    Given I am logged in as a KFS Chart Manager
    And   I clone a random Account with the following changes:
      | Name        | Test Account             |
      | Chart Code  | IT                       |
      | Description | [KFSQA-551] Test Account |
    Given I am logged in as a KFS Chart Administrator
    When  I blanket approve a Pre-Encumbrance Document that encumbers the random Account
    And   the Encumbrance document goes to FINAL
    And   I do an Open Encumbrances lookup for the Pre-Encumbrance document with Balance Type PE and Include All Pending Entries
    Then  the lookup should return results

  @KFSQA-739
  Scenario: E2E - PE Created, Approved and Accounting Line persists and updates GL
    Given   I am logged in as a KFS User for the PE document
    And     I start an empty Pre-Encumbrance document
    And     I add a source Accounting Line to the Pre-Encumbrance document with the following:
      | Chart Code   | IT |
      | Number       | U243700 |
      | Object Code  | 4023  |
      | Amount       | 100 |
    And     I save the Pre-Encumbrance document
    And     the Pre-Encumbrance document accounting lines equal the General Ledger Pending entries
    And     I submit the Pre-Encumbrance document
    And     I am logged in as a KFS Chart Administrator
    And     I view the Pre-Encumbrance document
    And     I blanket approve the Pre-Encumbrance document
    And     the Pre-Encumbrance document goes to one of the following statuses:
      | PROCESSED |
      | FINAL     |
    When    I am logged in as a KFS Chart Manager
    Then    the Pre-Encumbrance document accounting lines equal the General Ledger entries

  @KFSQA-740
  Scenario: E2E - PE Created, Approved and Accounting Line persists and updates GL
    Given   I am logged in as a KFS User for the PE document
    And     I start an empty Pre-Encumbrance document
    And     I add a source Accounting Line to the Pre-Encumbrance document with the following:
      | Chart Code   | IT |
      | Number       | G003704 |
      | Object Code  | 6100  |
      | Amount       | 1000 |
    And     I save the Pre-Encumbrance document
    And     I remember the Pre-Encumbrance document number
    And     the Pre-Encumbrance document accounting lines equal the General Ledger Pending entries
    And     I submit the Pre-Encumbrance document
    And     I am logged in as a KFS Chart Administrator
    And     I view the Pre-Encumbrance document
    And     I blanket approve the Pre-Encumbrance document
    And     the Pre-Encumbrance document goes to one of the following statuses:
      | PROCESSED |
      | FINAL     |
    And     I am logged in as a KFS Chart Manager
    And     the Pre-Encumbrance document accounting lines equal the General Ledger entries
    And     I am logged in as a KFS User for the PE document
    And     I start an empty Pre-Encumbrance document
    And     I add a target Accounting Line to the Pre-Encumbrance document with the following:
      | Chart Code   | IT |
      | Number       | G003704 |
      | Object Code  | 6100  |
      | Amount       | 200 |
    And     I save the Pre-Encumbrance document
    And     the Pre-Encumbrance document accounting lines equal the General Ledger Pending entries
    And     I submit the Pre-Encumbrance document
    And     I am logged in as a KFS Chart Administrator
    And     I view the Pre-Encumbrance document
    And     I blanket approve the Pre-Encumbrance document
    And     the Pre-Encumbrance document goes to one of the following statuses:
      | PROCESSED |
      | FINAL     |
    When    I am logged in as a KFS Chart Manager
    Then    The oustanding encumbrance for account G003704 and object code 6100 is 800

  @KFSQA-664 @cornell @wip
  Scenario: Process a Pre-Encumbrance using a revenue object code.
    Given   I am logged in as a KFS System Administrator
    And     I update Parameter KFS-FP Pre-Encumbrance KFS OBJECT_TYPES with the following values:
      | Parameter Value | IC |
    And     I finalize the Parameter document
    And     I am logged in as a KFS User
    And     I start a Pre-Encumbrance document for the current Month
    And     I add an Encumbrance Accounting Line to the Pre-Encumbrance document
    And     I save the Pre-Encumbrance document
    And     the Encumbrance Accounting Line appears in the document's GLPE entry
    And     I submit the Pre-Encumbrance document
    And     the Pre-Encumbrance document goes to ENROUTE
    And     I approve the Pre-Encumbrance document
    And     the Pre-Encumbrance document goes to FINAL
    And     I lookup the Accounting Line using Available Balances Lookup
    And     I select Include Pending Entries
    And     I select the Current Month from the General Ledger Balance Lookup
    And     The General Ledger Balance Lookup displays the Encumbrance Document ID
    And     The Encumbrance Accounting Line equals the displayed amounts
    Given   Nightly Batch Jobs run
    And     I am logged in as a KFS System Administrator
    When    I lookup the Encumbrance Document ID from the General Ledger
    Then    the Encumbrance Accounting Line appears in the document's GL entry
    And     I update Parameter KFS-FP Pre-Encumbrance KFS OBJECT_TYPES with the following values:
      | Parameter Value | EX |