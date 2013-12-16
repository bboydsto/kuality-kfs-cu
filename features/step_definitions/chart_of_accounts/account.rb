And /^I create an Account$/ do
  @account = create AccountObject
end

When /^I submit the Account$/ do
  @account.submit
end

Then /^the Account Maintenance Document goes to final$/ do
  @account.view
  on(AccountPage).document_status.should == 'Final'
end

When /^I create an account with blank SubFund group Code$/ do
  @account = create AccountObject, sub_fnd_group_cd: ''
end

Then /^I should get an error on saving that I left the SubFund Group Code field blank$/ do
  on(AccountPage).errors.should include 'Sub-Fund Group Code (SubFundGrpCd) is a required field.'
end

When /^I Create an Account and leave every field blank$/ do

  @account = create(AccountObject,
                    description:                      '',
                    chart_code:                       '',
                    number:                           '',
                    name:                             '',
                    org_cd:                           '',
                    campus_cd:                        '',
                    effective_date:                   '',
                    postal_cd:                        '',
                    city:                             '',
                    state:                            '',
                    address:                          '',
                    type_cd:                          '',
                    sub_fnd_group_cd:                 '',
                    higher_ed_funct_cd:               '',
                    restricted_status_cd:             '',
                    fo_principal_name:                '',
                    supervisor_principal_name:        '',
                    manager_principal_name:           '',
                    budget_record_level_cd:           '',
                    sufficient_funds_cd:              '',
                    expense_guideline_text:           '',
                    income_guideline_txt:             '',
                    purpose_text:                     '',
                    income_stream_financial_cost_cd:  '',
                    income_stream_account_number:     '')
end

Then /^I should get an error saying I left every field blank$/ do
  # TODO: Perhaps this will be provided by a service?
  @account_errors = YAML.load_file("#{File.dirname(__FILE__)}/../../../lib/resources/errors/account.yml")["required"]["create"]

  # TODO: Realistically, we will need to cycle through submitting and checking. However, we're still hashing that out.
  @account_errors.each do |error_msg|
    on(AccountPage).errors.should include error_msg
  end
end