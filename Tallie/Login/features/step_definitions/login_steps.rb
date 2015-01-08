
Given /^I (am on|go to) Login page$/ do |temp|
  #@login_page = LoginPage.new(@driver)
  login_page.visit
  #@current_page = @login_page
end

Then(/^I should be on Login page$/) do
 # @login_page = LoginPage.new(@driver)
  login_page.on_page
  #@current_page = @login_page
end

When /^I log in with valid credentials$/ do
  #@tallie_enterprise_account = TallieEnterpriseAccount.new
  login_page.login_with(tallie_enterprise_account.default_employee_email, tallie_enterprise_account.default_employee_password)
  tallie_enterprise_account.logged_in_employee[:name] = tallie_enterprise_account.default_employee_name
  tallie_enterprise_account.logged_in_employee[:email] = tallie_enterprise_account.default_employee_email
  tallie_enterprise_account.logged_in_employee[:password] = tallie_enterprise_account.default_employee_password
  purchases_page.on_page
end

Given(/^I am logged in to Tallie$/) do
  step %{I go to Login page}
  step %{I log in with valid credentials}
end

# When(/^I click Sign Out$/) do
#   #url_before_sign_out = @current_page.current_url
#   @current_page.sign_out
#   ##@current_page.wait_for(30) {url_before_sign_out != @current_page.current_url}
# end
