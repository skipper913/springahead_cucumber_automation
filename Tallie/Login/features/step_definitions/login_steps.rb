login_page_half_url = '/sso/Account/Logon'
Given /^I (am on|go to) Login page$/ do |temp|
  #@tallie_page = BasePage.new(@driver)
  #@tallie_page.visit(login_page_half_url)
  @login_page = LoginPage.new(@driver)
  @tallie_page = @login_page
end

Then(/^I should be on Login page$/) do

  LoginPage.new(@driver)

  # on_right_page = false
  # if @tallie_page.class == LoginPage
  #   on_right_page = true if @tallie_page.current_url.downcase.eql? @tallie_page.page_half_url
  # end
  # raise Exception, "You should be on Login page, but you are on #{@tallie_page.current_url}" unless on_right_page
  # begin
  #   LoginPage.new(@driver)
  # rescue
  #   raise Exception, "You should be on Login page! You are on #{@tallie_page.current_url}"
  # end
end


When /^I log in with valid credentials$/ do
  @tallie_enterprise_account = TallieEnterpriseAccount.new
  @login_page.login_with(@tallie_enterprise_account.default_employee_email, @tallie_enterprise_account.default_employee_password)
  @tallie_enterprise_account.logged_in_employee[:name] = @tallie_enterprise_account.default_employee_name
  @tallie_enterprise_account.logged_in_employee[:email] = @tallie_enterprise_account.default_employee_email
  @tallie_enterprise_account.logged_in_employee[:password] = @tallie_enterprise_account.default_employee_password
end

Given(/^I am logged in to Tallie$/) do
  step %{I go to Login page}
  step %{I log in with valid credentials}
end

When(/^I click Sign Out$/) do
  @tallie_page.sign_out
end
