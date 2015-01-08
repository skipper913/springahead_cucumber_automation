Then /^I see my name and enterprise displayed$/ do
  #@current_page = TopNav.new(@driver)
  top_nav.should_see_valid_employee_name(@tallie_enterprise_account.logged_in_employee[:name])
  top_nav.should_see_valid_enterprise_name(@tallie_enterprise_account.enterprise_name)
  # @current_page.should_see_valid_employee_name(@tallie_enterprise_account.logged_in_employee[:name])
  # @current_page.should_see_valid_enterprise_name(@tallie_enterprise_account.enterprise_name)
end