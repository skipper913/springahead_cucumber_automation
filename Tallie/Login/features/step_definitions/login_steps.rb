#require_relative '../../../Purchases/features/PurchasesPage'

Given /^I (am on|go to) Login page$/ do |temp|
  @tallie_page = LoginPage.new(@driver)
  @login_page = @tallie_page
end

When /^I log in with valid credentials$/ do
  @login_page = @tallie_page
  @tallie_enterprise_account = TallieEnterpriseAccount.new
  @login_page.with(@tallie_enterprise_account.default_employee_email, @tallie_enterprise_account.default_employee_password)
  @tallie_enterprise_account.logged_in_employee[:name] = @tallie_enterprise_account.default_employee_name
  @tallie_enterprise_account.logged_in_employee[:email] = @tallie_enterprise_account.default_employee_email
  @tallie_enterprise_account.logged_in_employee[:password] = @tallie_enterprise_account.default_employee_password
  #@purchase_page = PurchasesPage.new(@driver)
  #@tallie_page = @purchase_page
end

# Then /^I see my name and enterprise displayed$/ do
#   @tallie_enterprise_account
#   @purchase_page.should_see_valid_employee_name(@tallie_enterprise_account.logged_in_employee[:name])
#   @purchase_page.should_see_valid_enterprise_name(@tallie_enterprise_account.enterprise_name)
#
# end

Given(/^I am logged in to Tallie$/) do
  step %{I go to Login page}
  step %{I log in with valid credentials}
end

When(/^I click Sign Out$/) do
  @tallie_page.sign_out
end
