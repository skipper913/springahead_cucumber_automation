Then /^I see my name and enterprise displayed$/ do
  @tallie_page = TopNav.new(@driver)
  @tallie_page.should_see_valid_employee_name(@tallie_enterprise_account.logged_in_employee[:name])
  @tallie_page.should_see_valid_enterprise_name(@tallie_enterprise_account.enterprise_name)
end