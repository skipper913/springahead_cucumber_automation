require_relative '../../../Purchases/PurchasesPage'

When /^I log in with valid login credentials$/ do
  @login_page = @tallie_page
  @tallie_enterprise_account = TallieEnterpriseAccount.new
  @login_page.with(@tallie_enterprise_account.default_employee_email, @tallie_enterprise_account.default_employee_password)
  @purchase_page = PurchasesPage.new(@driver)
  @tallie_page = @purchase_page
end

Then /^I see my name and enterprise displayed$/ do
  @purchase_page.should_see_valid_employee_name('Alpha Test')

end