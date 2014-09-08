And /^I (#{AccountPage::available_buttons}) an Account document$/ do |button|
  button.gsub!(' ', '_')
  @account = create AccountObject, press: button
  sleep 10 if (button == 'blanket_approve') || (button == 'approve')
  step 'I add the account to the stack'
end

And /^I copy an Account$/ do
  on(AccountLookupPage).copy_random
  on AccountPage do |page|
    page.description.fit 'AFT testing copy'
    page.chart_code.fit get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
    page.number.fit random_alphanums(4, 'AFT')
    @account = make AccountObject
    @account.chart_code = page.chart_code.text
    @account.number = page.number.text
    @account.description = page.description
    @account.document_id = page.document_id
    @document_id = page.document_id
    page.save
    page.left_errmsg_text.should include 'Document was successfully saved.'
  end
  step 'I add the account to the stack'
end

And /^I save an Account with a lower case Sub Fund Program$/ do
  @account = create AccountObject, sub_fund_group_code: 'board', press: :save
  step 'I add the account to the stack'
end

When /^I submit an account with blank SubFund group Code$/ do
  @account = create AccountObject, sub_fund_group_code: '', press: :submit
  step 'I add the account to the stack'
end

Then /^I should get an error on saving that I left the SubFund Group Code field blank$/ do
  on(AccountPage).errors.should include 'Sub-Fund Group Code (SubFundGrpCd) is a required field.'
end

Then /^the Account Maintenance Document saves with no errors$/  do
  on(AccountPage).document_status.should == 'SAVED'
end

Then /^the Account Maintenance Document has no errors$/  do
  on(AccountPage).document_status.should == 'ENROUTE'
end

And /^I edit an Account to enter a Sub Fund Program in lower case$/ do
  visit(MainPage).account
  on AccountLookupPage do |page|
    page.subfund_program_code.set 'BOARD' #TODO config
    page.search
    page.edit_random
  end
  on AccountPage do |page|
    @account = make AccountObject
    page.description.set random_alphanums(40, 'AFT')
    page.subfund_program_code.set 'board' #TODO config
    page.save
  end
  step 'I add the account to the stack'
end

When /^I enter a Sub-Fund Program Code of (.*)$/ do |sub_fund_program_code|
  on AccountPage do |page|
    @account = make AccountObject
    page.description.set random_alphanums(40, 'AFT')
    page.subfund_program_code.set sub_fund_program_code
    page.save
  end
  step 'I add the account to the stack'
end

And /^I edit an Account with a Sub-Fund Group Code of (.*)/ do |sub_fund_group_code|
  visit(MainPage).account
  on AccountLookupPage do |page|
    page.sub_fund_group_code.fit sub_fund_group_code
    page.search
    page.edit_random
  end
end

When /^I enter (.*) as an invalid Major Reporting Category Code$/  do |major_reporting_category_code|
  on AccountPage do |page|
    @account = make AccountObject
    page.description.set random_alphanums(40, 'AFT')
    page.major_reporting_category_code.fit major_reporting_category_code
    page.save
  end
  step 'I add the account to the stack'
end

When /^I enter (.*) as an invalid Appropriation Account Number$/  do |appropriation_account_number|
  on AccountPage do |page|
    @account = make AccountObject
    page.description.set random_alphanums(40, 'AFT')
    page.appropriation_account_number.fit appropriation_account_number
    page.save
  end
  step 'I add the account to the stack'
end

When /^I enter (.*) as an invalid Labor Benefit Rate Category Code$/  do |labor_benefit_rate_category_code|
  on AccountPage do |page|
    @account = make AccountObject
    page.description.set random_alphanums(40, 'AFT')
    page.labor_benefit_rate_category_code.fit labor_benefit_rate_category_code
    page.save
  end
  step 'I add the account to the stack'
end

When /^I save an Account document with only the ([^"]*) field populated$/ do |field|
  # TODO: Swap this out for Account#defaults
  default_fields = {
      description:          random_alphanums(40, 'AFT'),
      chart_code:           get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
      number:               random_alphanums(7),
      name:                 random_alphanums(10),
      organization_code:    '01G0',#TODO config?
      campus_code:          get_aft_parameter_value(ParameterConstants::DEFAULT_CAMPUS_CODE),
      effective_date:       '01/01/2010',
      postal_code:          get_random_postal_code('*'),
      city:                 get_generic_city,
      state:                get_random_state_code,
      address:              get_generic_address_1,
      type_code:            get_aft_parameter_value(ParameterConstants::DEFAULT_CAMPUS_TYPE_CODE),
      sub_fund_group_code:  'ADMSYS',#TODO config?
      higher_ed_funct_code: '4000',#TODO config?
      restricted_status_code:     'U - Unrestricted',#TODO config?
      fo_principal_name:          get_aft_parameter_value(ParameterConstants::DEFAULT_FISCAL_OFFICER),
      supervisor_principal_name:  get_aft_parameter_value(ParameterConstants::DEFAULT_SUPERVISOR),
      manager_principal_name: get_aft_parameter_value(ParameterConstants::DEFAULT_MANAGER),
      budget_record_level_code:   'C - Consolidation',#TODO config?
      sufficient_funds_code:      'C - Consolidation',#TODO config?
      expense_guideline_text:     'expense guideline text',
      income_guideline_txt: 'incomde guideline text',
      purpose_text:         'purpose text',
      labor_benefit_rate_cat_code:      'CC'#TODO config?
  }

  # TODO: Make the Account document creation with a single field step more flexible.
  case field
    when 'Description'
      default_fields.each {|k, _| default_fields[k] = '' unless k.to_s.eql?('description') }
  end

  @account = create AccountObject, default_fields.merge({press: :save})
  step 'I add the account to the stack'
end

And /^I edit an Account$/ do
  visit(MainPage).account
  on AccountLookupPage do |page|
    page.search
    page.edit_random
  end
  on AccountPage do |page|
    @account = make AccountObject
    page.description.set random_alphanums(40, 'AFT')
    @account.document_id = page.document_id
    @account.description = page.description
  end
  step 'I add the account to the stack'
end

When /^I input a lowercase Major Reporting Category Code value$/  do
  on(AccountPage).major_reporting_category_code.fit 'faculty'
end

And /^I create an Account with an Appropriation Account Number of (.*) and Sub-Fund Program Code of (.*)/ do |appropriation_accountNumber, subfund_program_code|
  @account = create AccountObject
  on AccountPage do |page|
    page.appropriation_account_number.set appropriation_accountNumber
    page.subfund_program_code.set subfund_program_code
    @account.document_id = page.document_id
  end
  step 'I add the account to the stack'
end

And /^I enter Sub Fund Group Code of (.*)/ do |sub_fund_group_code|
  on(AccountPage).sub_fund_group_code.set sub_fund_group_code
end

And /^I enter Sub Fund Program Code of (.*)/  do |subfund_program_code|
  on(AccountPage).subfund_program_code.set subfund_program_code
end

And /^I enter Appropriation Account Number of (.*)/  do |appropriation_account_number|
  on(AccountPage).appropriation_account_number.set appropriation_account_number
end

And /^I close the Account$/ do
  visit(MainPage).account

  # First, let's get a random continuation account
  random_continuation_account_number = on(AccountLookupPage).get_random_account_number
  # Now, let's try to close that account
  on AccountLookupPage do |page|
    page.chart_code.fit     @account.chart_code
    page.account_number.fit @account.number
    page.closed_no.set # There's no point in doing this if the account is already closed. Probably want an error, if a search with this setting fails.
    page.search
    page.edit_random # should only select the guy we want, after all
  end
  on AccountPage do |page|
    page.description.fit                 "Closing Account #{@account.number}"
    page.continuation_account_number.fit random_continuation_account_number
    page.continuation_chart_code.fit     'IT - Ithaca Campus' #TODO config
    page.account_expiration_date.fit     page.effective_date.value
    page.closed.set
  end
end

And /^I edit the Account$/ do
  visit(MainPage).account
  on AccountLookupPage do |page|
    page.chart_code.fit @account.chart_code
    page.account_number.fit @account.number
    page.search
    page.edit_random
  end
  on AccountPage do |page|
    page.description.fit 'AFT testing edit'
    @account.description = 'AFT testing edit'
    @account.document_id = page.document_id
  end
end

And /^I enter a Continuation Chart Of Accounts Code that equals the Chart of Account Code$/ do
  on(AccountPage) { |page| page.continuation_chart_code.fit page.chart_code.text }
end

And /^I enter a Continuation Account Number that equals the Account Number$/ do
  on(AccountPage) { |page| page.continuation_account_number.fit page.original_account_number }
end

And /^I clone a random Account with the following changes:$/ do |table|
  step 'I clone Account nil with the following changes:', table
end

And /^I clone Account (.*) with the following changes:$/ do |account_number, table|
  unless account_number.empty?
    account_number = account_number == 'nil' ? nil : account_number
    updates = table.rows_hash
    updates.delete_if { |k,v| v.empty? }
    updates['Indirect Cost Recovery Active Indicator'] = updates['Indirect Cost Recovery Active Indicator'].to_sym unless updates['Indirect Cost Recovery Active Indicator'].nil?

    visit(MainPage).account
    on AccountLookupPage do |page|
      page.chart_code.fit     'IT' #TODO config
      page.account_number.fit account_number
      page.search
      page.wait_for_search_results
      page.copy_random
    end
    on AccountPage do |page|
      @document_id = page.document_id
      @account = make AccountObject, description: updates['Description'],
                      name:        updates['Name'],
                      chart_code:  updates['Chart Code'],
                      number:      random_alphanums(7),
                      document_id: page.document_id,
                      press: nil
      page.description.fit @account.description
      page.name.fit        @account.name
      page.chart_code.fit  @account.chart_code
      page.number.fit      @account.number
      page.supervisor_principal_name.fit @account.supervisor_principal_name
      unless updates['Indirect Cost Recovery Chart Of Accounts Code'] && updates['Indirect Cost Recovery Account Number'] &&
             updates['Indirect Cost Recovery Account Line Percent'] && updates['Indirect Cost Recovery Active Indicator']
        @account.icr_accounts.add chart_of_accounts_code: updates['Indirect Cost Recovery Chart Of Accounts Code'],
                                  account_number:         updates['Indirect Cost Recovery Account Number'],
                                  line_percent:   updates['Indirect Cost Recovery Account Line Percent'],
                                  active_indicator:       updates['Indirect Cost Recovery Active Indicator']
      end

      page.blanket_approve
      sleep 5
    end

    step 'I add the account to the stack'
  end
end

And /^I extend the Expiration Date of the Account document (\d+) days$/ do |days|
  on(AccountPage).account_expiration_date.fit (@account.account_expiration_date + days.to_i).strftime('%m/%d/%Y')
end

And /^I find an expired Account$/ do
  visit(MainPage).account
  on AccountLookupPage do |page|
    # FIXME: These values should be set by a service.
    page.chart_code.fit     get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
    page.account_number.fit '147*'
    page.search
    page.sort_results_by('Account Expiration Date')
    page.sort_results_by('Account Expiration Date') # Need to do this twice to get the expired ones in front

    col_index = page.column_index(:account_expiration_date)
    account_row_index = page.results_table
                            .rows.collect { |row| row[col_index].text if row[col_index].text.split('/').length == 3}[1..page.results_table.rows.length]
                            .collect { |cell| DateTime.strptime(cell, '%m/%d/%Y') < DateTime.now }.index(true) + 1 # Finds the first qualified one.
    account_row_index = rand(account_row_index..page.results_table.rows.length)

    # We're only really interested in these parts
    @account = make AccountObject
    @account.number = page.results_table[account_row_index][page.column_index(:account_number)].text
    @account.chart_code = page.results_table[account_row_index][page.column_index(:chart_code)].text
    @account.account_expiration_date = DateTime.strptime(page.results_table[account_row_index][page.column_index(:account_expiration_date)].text, '%m/%d/%Y')
    step 'I add the account to the stack'
  end
end

And /^I use these Accounts:$/ do |table|
  existing_accounts = table.raw.flatten

  visit(MainPage).account
  on AccountLookupPage do |page|
    existing_accounts.each do |account_number|
      # FIXME: These values should be set by a service.
      page.chart_code.fit     get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
      page.account_number.fit account_number
      page.search

      # We're only really interested in these parts
      @account = make AccountObject
      @account.number = page.results_table[1][page.column_index(:account_number)].text
      @account.chart_code = page.results_table[1][page.column_index(:chart_code)].text
      step 'I add the account to the stack'
    end
  end

end

When /^I start to copy a Contracts and Grants Account$/ do
  cg_account_number = get_account_of_type 'Contracts & Grants with ICR'
  visit(MainPage).account
  on AccountLookupPage do |alp|
    alp.chart_code.fit     get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
    alp.account_number.fit cg_account_number
    alp.search

    alp.item_row(cg_account_number).exist?.should
    alp.copy_random
  end

  @account = make AccountObject
  @account.absorb! :old
  @account.edit description: @account.description # This will be auto-generated, but not auto-populated
  #               number:      @account.number
  step 'I add the account to the stack'
end

And /^the fields from the old Account populate those in the new Account document$/ do
  # I make a temporary data object by absorbing the 'New' Account information
  # I compare that 'New' d.o. to the 'Old' d.o. (@account)
  @account = make AccountObject
  @account.absorb! :new
  step 'I add the account to the stack'

  (@accounts[0] == @accounts[1]).should
end

And /^I add the account to the stack$/ do
  @accounts = @accounts.nil? ? [@account] : @accounts + [@account]
end

And /^I update the Account with the following changes:$/ do |updates|
  updates = updates.rows_hash.snake_case_key

  # Now go through and make sure anything with "Same as Original" pulls from the previous one.
  # We assume that we have at least two accounts in the stack and that the last one is the account to update.
  updates.each do |k, v|
    new_val = case v
                when 'Same as Original'
                  @accounts[-2].instance_variable_get("@#{k}")
                when 'Checked'
                  :set
                when 'Unchecked'
                  :clear
                when 'Random'
                  case k
                    when :description
                      random_alphanums(37, 'AFT')
                    when :number
                      random_alphanums(7).upcase
                    else
                      v # No change
                  end
                else
                  v # No change
              end
    updates.store k, new_val
  end

  # If you need to support additional fields, you'll need to implement them above.

  @account.edit updates

  # Now, let's make sure the changes persisted.
  on AccountPage do |page|
    values_on_page = page.new_account_data
    values_on_page.keys.each do |cfda_field|
      unless updates[cfda_field].nil?
        @account.instance_variable_get("@#{cfda_field}").should == updates[cfda_field]
        values_on_page[cfda_field].should == @account.instance_variable_get("@#{cfda_field}")
      end
    end
  end

  @accounts[-1] = @account # Update that stack!
end

And /^I update the Account's Contracts and Grants tab with the following changes:$/ do |updates|
  updates = updates.rows_hash.snake_case_key

  # Now go through and make sure anything with "Same as Original" pulls from the previous one.
  # We assume that we have at least two accounts in the stack and that the last one is the account to update.
  updates.each do |k, v|
    new_val = case v
                when 'Same as Original'
                  @accounts[-2].instance_variable_get("@#{k}")
                when 'Checked'
                  :set
                when 'Unchecked'
                  :clear
                else
                  v
              end
    updates.store k, new_val
  end
  # If you need to support additional fields, you'll need to implement them above.

  @account.edit updates

  # Now, let's make sure the changes persisted.
  on AccountPage do |page|
    values_on_page = page.new_account_data
    [
      :contract_control_chart_of_accounts_code, :contract_control_account_number,
      :account_icr_type_code, :indirect_cost_rate, :cfda_number, :cg_account_responsibility_id,
      :invoice_frequency_code, :invoice_type_code, :everify_indicator, :cost_share_for_project_number
    ].each do |cfda_field|
      unless updates[cfda_field].nil?
        @account.instance_variable_get("@#{cfda_field}").should == updates[cfda_field]
        values_on_page[cfda_field].should == @account.instance_variable_get("@#{cfda_field}")
      end
    end
  end

  @accounts[-1] = @account # Update that stack!
end

And /^I copy the old Account's Indirect Cost Recovery tab to the new Account$/ do
  update = @accounts[-2].icr_accounts.to_update
  @account.edit update
  @accounts[-1] = @account # Update that stack!
end

And /^I add an additional Indirect Cost Recovery Account if the Account's Indirect Cost Recovery tab is empty$/ do
  if @account.icr_accounts.length < 1 || @account.icr_accounts.account_line_percent_sum < 100
    @account.icr_accounts.add chart_of_accounts_code: get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE),
                              account_number:         '',
                              account_line_percent:   (@account.icr_accounts.length < 1 ? '100' : (100 - @account.icr_accounts.account_line_percent_sum).to_s),
                              active_indicator:       :set
    @accounts[-1] = @account # Update that stack!
  end
end

Then /^the values submitted for the Account document persist$/ do
  # Now, let's make sure the changes persisted.
  on AccountPage do |page|
    values_on_page = page.new_account_data

    values_on_page.keys.each do |cfda_field|
      unless values_on_page[cfda_field].nil?
        value_in_memory = @account.instance_variable_get("@#{cfda_field}")

        if values_on_page[cfda_field].is_a? String
          values_on_page[cfda_field].eql_ignoring_whitespace?(value_in_memory).should be true
        else
          values_on_page[cfda_field].should == value_in_memory
        end
      end
    end
  end
  icra_collection_on_page = @account.icr_accounts.updates_pulled_from_page :old
  icra_collection_on_page.each_with_index { |icra, i| icra.should == @account.icr_accounts[i].to_update }
end