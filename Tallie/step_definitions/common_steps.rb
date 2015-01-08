When(/^I click Sign Out$/) do
  #url_before_sign_out = @current_page.current_url
  top_nav.sign_out
  ##@current_page.wait_for(30) {url_before_sign_out != @current_page.current_url}
end

Then(/^I stopped/) do
  puts "Just stop!"
end