Then /^I see my name and enterprise displayed$/ do
  top_nav.should_see_valid_employee_name(@tallie_enterprise_account.logged_in_employee[:name])
  top_nav.should_see_valid_enterprise_name(@tallie_enterprise_account.enterprise_name)
end