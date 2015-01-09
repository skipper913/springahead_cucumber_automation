
Given /^I (am on|go to) Credit Card page$/ do |temp|
  step %q{I am logged in to Tallie} #TODO need to bypass login and go to purchases page
  #cc_page = CreditCardPage.new(@driver)
  cc_page.visit
end


And(/^I add (Test Bank|DagBank) Credit Card$/) do |bank_name|
  cc_page.add_cc(bank_name)
end

And(/^I should see (Test Bank|DagBank) Credit Card added on the page$/) do |bank_name|
  cc_page.should_see_cc_added(bank_name)
  @cc_bank_name_added = bank_name
end


