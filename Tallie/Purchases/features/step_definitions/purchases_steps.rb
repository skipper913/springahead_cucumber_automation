

Given /^I (am on|go to) Purchases page$/ do |temp|
  step %q{I am logged in to Tallie} #TODO need to bypass login and go to purchases page
end

When(/^I add a new expense with below data by clicking New Expense button:$/) do |table|
  @added_expense_attributes = table.rows_hash
  purchases_page.add_via_popup(set_random_value_to_expense_attributes(@added_expense_attributes))
  puts "@added_expense_attributes: #{@added_expense_attributes.inspect}"
end

Then(/^the new expense tile is added on the page$/) do
  purchases_page.should_have_expense(@added_expense_attributes)
end

Then(/^Expense tile is saved with edits$/) do
  purchases_page.should_have_expense(@edit_expense_attributes)
end

When(/^I edit an expense as below:$/) do |table|
  ##TODO: Need to create expense (via db query, RestAPI, etc)
  @edit_expense_attributes = table.rows_hash
  purchases_page.add_via_popup if purchases_page.number_of_expenses == 0
  puts "@edit_expense_attributes: #{@edit_expense_attributes.inspect}"
  purchases_page.edit_any_expense(set_random_value_to_expense_attributes(@edit_expense_attributes))
end

When(/^I add below itemizations to an expense:$/) do |table|
  ##TODO: Need to create expense (via db query, RestAPI, etc)
  purchases_page.add_via_popup if purchases_page.find_expense_with_no_item.nil?
  @itemized_expense_attributes = table.rows_hash
  @itemized_expense_attributes = @itemized_expense_attributes.each do |item, attributes|
    @itemized_expense_attributes[item] = eval(attributes)
    set_random_value_to_expense_attributes(@itemized_expense_attributes[item])
  end
  purchases_page.add_item_to_any_expense_with_no_item(@itemized_expense_attributes)
end

Then(/^I delete all Purchases$/) do
  purchases_page.delete_all_purchases
end


