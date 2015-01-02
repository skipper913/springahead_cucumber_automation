require_relative '../../../../Tallie/Login/features/step_definitions/login_steps'
require_relative '../../../../Tallie/Login/features/LoginPage'

Given /^I (am on|go to) Purchases page$/ do |temp|
  step %q{I am logged in to Tallie} #TODO need to bypass login and go to purchases page
  @tallie_page = PurchasesPage.new(@driver)
  @purchases_page = @tallie_page
end


When(/^I add a new expense with below data by clicking New Expense button:$/) do |table|
  @added_expense_attributes = table.rows_hash
  @added_expense_attributes['merchant'] = @purchases_page.auto_generate_merchant if @added_expense_attributes['merchant'].downcase.include? 'any text'
  @added_expense_attributes['reason'] = @purchases_page.auto_generate_reason if @added_expense_attributes['reason'].downcase.include? 'any text'
  @added_expense_attributes['amount'] = @purchases_page.auto_generate_amount if @added_expense_attributes['amount'].downcase.include? 'any text'

  @purchases_page.add_via_popup(@added_expense_attributes)
  @added_expense_attributes['date'] = DateTime.now.strftime('%-m/%-d/%Y')
  puts "@added_expense_attributes: #{@added_expense_attributes.inspect}"
end

Then(/^the new expense tile is added on the page$/) do
  @purchases_page.should_have_expense(@added_expense_attributes)
end
Then(/^Expense tile is saved with edits$/) do
  @purchases_page.should_have_expense(@edit_expense_attributes)
end

When(/^I edit a expense as below:$/) do |table|
  ##TODO: Need to create expense (via db query, RestAPI, etc)
  step %q{I add a new expense with below data by clicking New Expense button:} if @purchases_page.number_of_expenses == 0

  @edit_expense_attributes = table.rows_hash
  @edit_expense_attributes['merchant'] = @purchases_page.auto_generate_merchant if @edit_expense_attributes['merchant'].downcase.include? 'any text'
  @edit_expense_attributes['reason'] = @purchases_page.auto_generate_reason if @edit_expense_attributes['reason'].downcase.include? 'any text'
  @edit_expense_attributes['amount'] = @purchases_page.auto_generate_amount if @edit_expense_attributes['amount'].downcase.include? 'any text'
  @edit_expense_attributes['date'] = @purchases_page.any_past_date
  puts "@edit_expense_attributes: #{@edit_expense_attributes.inspect}"

  @purchases_page.edit_any_expense(@edit_expense_attributes)
end
