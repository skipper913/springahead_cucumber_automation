require_relative '../../../Login/features/step_definitions/login_steps'
require_relative '../../../Login/features/LoginPage'
require_relative '../../../Purchases/features/step_definitions/import_cc_steps'
require_relative '../../../Purchases/features/PurchasesPage'

Given /^I (am on|go to) Credit Card page$/ do |temp|
  step %q{I am logged in to Tallie} #TODO need to bypass login and go to purchases page
  @tallie_page = CreditCardPage.new(@driver)
  @cc_page = @tallie_page
end


And(/^I add (Test Bank|DagBank) Credit Card$/) do |bank_name|
  @cc_page.add_cc(bank_name)
end

And(/^I should see (Test Bank|DagBank) Credit Card added on the page$/) do |bank_name|
  @cc_page.should_see_cc_added(bank_name)
  @cc_bank_name_added = bank_name
end

And(/^I delete all Credit Card added$/) do
  @cc_page.delete_all
end
