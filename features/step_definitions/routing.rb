Then /^I switch to the user with the next Pending Action in the Route Log$/ do
  new_user = ''
  on(FinancialProcessingPage) do |page|
    page.expand_all
    page.pnd_act_req_table[1][2].links[0].click
    page.use_new_tab
    page.frm.div(id: 'tab-Overview-div').tables[0][1].tds[0].should exist
    page.frm.div(id: 'tab-Overview-div').tables[0][1].tds[0].text.empty?.should_not
    new_user = page.frm.div(id: 'tab-Overview-div').tables[0][1].tds[0].text
    page.close_children
  end

  step "I am logged in as \"#{new_user}\""
end

Then /^I switch to the user with the next Pending Action in the Route Log for the (.*) document$/ do |document|
  new_user = ''
  on page_class_for(document) do |page|
    page.expand_all
    page.pnd_act_req_table[1][2].links[0].click
    page.use_new_tab
    page.frm.div(id: 'tab-Overview-div').tables[0][1].tds[0].should exist
    page.frm.div(id: 'tab-Overview-div').tables[0][1].tds[0].text.empty?.should_not
    if page.frm.div(id: 'tab-Overview-div').tables[0][1].text.include?('Principal Name:')
       new_user = page.frm.div(id: 'tab-Overview-div').tables[0][1].tds[0].text
    else
      # TODO : this is for group.  any other alternative ?
      mbr_tr = page.frm.select(id: 'document.members[0].memberTypeCode').parent.parent.parent
      new_user = mbr_tr[4].text
    end

    page.close_children
  end

  step "I am logged in as \"#{new_user}\""
end

When /^I route the (.*) document to (.*) by clicking (.*) for each request$/ do |document, target_status, button|
  step "I view the #{document} document"

  unless on(page_object_for(document)).document_status == target_status
    step 'I switch to the user with the next Pending Action in the Route Log'
    step "I view the #{document} document"
    step "I #{button} the #{document} document if it is not already FINAL"
  end

end

And /^the next pending action for the (.*) document is an? (.*) from a (.*)$/ do |document, action, user_type|
  on page_object_for(document) do |page|
    page.pnd_act_req_table_action.visible?.should
    page.pnd_act_req_table_action.should match(/#{action}/)
    page.pnd_act_req_table_annotation.should match(/#{user_type}/)
  end
end

And /^the (.*) document routes successfully through this route:$/ do |document, route|
  # route is a route.hashes.keys # => [:Role, :Action]
  route.hashes.each do |route_step|
    step "the next pending action for the #{document} document is a #{route_step[:Action]} from a #{route_step[:Role]}"
    step "I switch to the user with the next Pending Action in the Route Log for the #{document} document"
    step "I approve the #{document} document"
    step 'The document should have no errors'
  end
end
