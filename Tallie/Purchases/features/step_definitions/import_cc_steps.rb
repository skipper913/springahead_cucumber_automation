
And(/^I should see the credit card account listed in the credit card list on Purchase page$/) do
   # @purchases_page = PurchasesPage.new(@driver) unless defined? @purchases_page
    purchases_page.open_cc_popup
    purchases_page.cc_should_be_listed @cc_bank_name_added
end