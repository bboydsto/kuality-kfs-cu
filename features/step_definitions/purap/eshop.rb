When /^I visit the e-SHOP$/ do
  visit(MainPage).e_shop
end

And /^I select a e\-SHOP Hosted Supplier$/ do
  on ShopCatalogPage do |p|
    p.hosted_suppliers[rand(p.hosted_suppliers_buttons.length - 1)].click
  end
end

When /^I search for an e\-SHOP item with the following qualifications:$/ do |qualifications|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then /^the e\-SHOP item search should return (\d+) result$/ do |result_count|
  pending # express the regexp above with the code you wish you had
end

When /^I enter a quantity of (\d+) on the e\-SHOP item search result$/ do |quantity|
  pending # express the regexp above with the code you wish you had
end

And /^I add the e\-SHOP item search result to my Cart$/ do
  pending # express the regexp above with the code you wish you had
end

And /^I view my e\-SHOP Cart$/ do
  pending # express the regexp above with the code you wish you had
end

And /^I add a note to my e\-SHOP Cart$/ do
  pending # express the regexp above with the code you wish you had
end

And /^I save my e\-SHOP Cart$/ do
  pending # express the regexp above with the code you wish you had
end

And /^I assign my e\-SHOP Cart to an e\-SHOP assignee$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should be congratulated on a successful e\-SHOP Cart assignment$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I retrieve my e\-SHOP Cart$/ do
  pending # express the regexp above with the code you wish you had
end

And /^I submit the e\-SHOP Cart$/ do
  pending # express the regexp above with the code you wish you had
end

And /^I close the (.*) document, saving it if necessary$/ do |document|
  pending # express the regexp above with the code you wish you had
end

Then /^the Account Distribution Method is "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

And /^the e\-SHOP Flags says "(.*?)"$/ do |desired_flags_msg|
  pending # express the regexp above with the code you wish you had
end

And /^the Payment Request Positive Approval Required field equals "(.*?)"$/ do |desired_field_value|
  pending # express the regexp above with the code you wish you had
end

Given /^I use my Action List to route the (.*) document to (.*) by clicking approve for each request$/ do |document, status|
  pending # express the regexp above with the code you wish you had
end

When /^I open the (.*) document by searching for it in e\-SHOP$/ do |document|
  pending # express the regexp above with the code you wish you had
end

Then /^the e\-SHOP document status is Completed$/ do
  pending # express the regexp above with the code you wish you had
end

And /^the Delivery Instructions displayed match what came from the Purchase Order$/ do
  pending # express the regexp above with the code you wish you had
end

And /^the Notes to Supplier displayed match what came from the Purchase Order$/ do
  pending # express the regexp above with the code you wish you had
end

And /^the Attachments for Supplier match what came from the Purchase Order$/ do
  pending # express the regexp above with the code you wish you had
end