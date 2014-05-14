And /^I press the (.*) key$/ do |key|
  @browser.send_keys snake_case(key)
end

Then /^my cursor is on the (.*) button$/ do |button|
  puts @browser.frm.input(title: button).focused?
  @browser.frm.input(title: button).focused?.should be_true
end

Then /^my cursor is on the (.*) field$/ do |title|
  puts @browser.frm.input(id: 'attachmentFile').focused?
  case title
  when 'Attach File'
    @browser.frm.input(id: 'attachmentFile').focused?.should be_true
  else
    pending "The action for #{title} has not yet been defined for this step."
  end
end

When /^I click the (.*) button$/ do |button|
  @browser.frm.input(title: button).click
end