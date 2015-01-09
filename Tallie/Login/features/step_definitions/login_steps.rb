
Given /^I (am on|go to) Login page$/ do |temp|
  login_page.visit
end

Then(/^I should be on Login page$/) do
  login_page.on_page
end

When /^I log in with valid credentials$/ do
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
