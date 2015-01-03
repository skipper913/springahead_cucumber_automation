require_relative '../../../../Tallie/Login/features/step_definitions/login_steps'
require_relative '../../../../Tallie/Login/features/LoginPage'

Given /^I (am on|go to) Purchases page$/ do |temp|
  step %q{I am logged in to Tallie} #TODO need to bypass login and go to purchases page
  @tallie_page = PurchasesPage.new(@driver)
  @purchases_page = @tallie_page
end


When(/^I add a new expense with below data by clicking New Expense button:$/) do |table|
  @added_expense_attributes = table.rows_hash
  @purchases_page.add_via_popup(set_random_value_to_expense_attributes(@added_expense_attributes))
  #@added_expense_attributes['date'] = DateTime.now.strftime('%-m/%-d/%Y')
  puts "@added_expense_attributes: #{@added_expense_attributes.inspect}"
end

Then(/^the new expense tile is added on the page$/) do
  @purchases_page.should_have_expense(@added_expense_attributes)
end
Then(/^Expense tile is saved with edits$/) do
  @purchases_page.should_have_expense(@edit_expense_attributes)
end

When(/^I edit an expense as below:$/) do |table|
  ##TODO: Need to create expense (via db query, RestAPI, etc)
  @edit_expense_attributes = table.rows_hash
  step %q{I add a new expense with below data by clicking New Expense button:} if @purchases_page.number_of_expenses == 0
  puts "@edit_expense_attributes: #{@edit_expense_attributes.inspect}"
  @purchases_page.edit_any_expense(set_random_value_to_expense_attributes(@edit_expense_attributes))
end


When(/^I add below itemizations to an expense:$/) do |table|
  ##TODO: Need to create expense (via db query, RestAPI, etc)
  step %q{I add a new expense with below data by clicking New Expense button:} if @purchases_page.number_of_expenses == 0
  @itemized_expense_attributes = table.rows_hash
  @itemized_expense_attributes = @itemized_expense_attributes.each do |item, attributes|
    @itemized_expense_attributes[item] = eval(attributes)
    set_random_value_to_expense_attributes(@itemized_expense_attributes[item])
  end
  @purchases_page.add_item_to_any_expense_with_no_item(@itemized_expense_attributes)
end

def set_random_value_to_expense_attributes(attributes)
  if (attributes.has_key? 'merchant')
    attributes['merchant'] = @purchases_page.auto_generate_merchant if attributes['merchant'].downcase.include? 'any text'
  end
  if (attributes.has_key? 'reason')
    attributes['reason'] = @purchases_page.auto_generate_reason if attributes['reason'].downcase.include? 'any text'
  end
  if (attributes.has_key? 'reason_itemize')
    attributes['reason_itemize'] = @purchases_page.auto_generate_reason if attributes['reason_itemize'].downcase.include? 'any text'
  end
  if attributes.has_key? 'amount'
    attributes['amount'] = @purchases_page.auto_generate_amount if attributes['amount'].downcase.include? 'any'
  end
  if (attributes.has_key? 'amount_itemize')
    attributes['amount_itemize'] = @purchases_page.auto_generate_amount if attributes['amount_itemize'].downcase.include? 'any'
  end
  attributes['date'] = @purchases_page.any_past_date
  return attributes
end