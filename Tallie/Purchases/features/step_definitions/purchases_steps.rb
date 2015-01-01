require_relative '../../../../Tallie/Login/features/step_definitions/login_steps'
require_relative '../../../../Tallie/Login/features/LoginPage'

Given /^I (am on|go to) Purchases page$/ do |temp|
  step %{I am logged in to Tallie}  #TODO need to bypass login and go to purchases page
  @tallie_page = PurchasesPage.new(@driver)
  @purchases_page = @tallie_page
end


When(/^I add a new expense with below data by clicking New Expense button:$/) do |table|
  @added_expense_attributes = table.rows_hash
  @added_expense_attributes['reason'] = "#{rand(100...1000)} - Automation" if @added_expense_attributes['reason'].downcase.include? 'auto-generate reason'
  if @added_expense_attributes['amount'].downcase.include? 'auto-generate amount'
    @added_expense_attributes['amount'] = '%.2f' % (rand * 100)
  end

  puts "@added_expense_attributes: #{@added_expense_attributes.inspect}"
  @purchases_page.add_via_popup(@added_expense_attributes)

end

Then(/^the new expense tile is added on the page$/) do
  @added_expense_attributes
  @purchases_page.have_expense(@added_expense_attributes)
end