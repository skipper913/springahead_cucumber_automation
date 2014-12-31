#require_relative '../Login/features/step_definitions/login_steps'
#require_relative '../Login/features/step_definitions/LoginPage'

# Given /^I (am on|go to) (Purchases|Free Trial|Login) page$/ do |temp, page_name|
#   case page_name
#     when 'Free Trial', 'Login'
#      # @tallie_page = Object.const_get("#{page_name.gsub(" ","")}Page").new(@driver)
#     when 'Purchases'
#       step %{I am logged in to Tallie}  #TODO need to bypass login and go to purchases page
#     else
#       raise Exception "Unknown page: #{page_name}!"
#   end
#   @tallie_page = Object.const_get("#{page_name.gsub(" ","")}Page").new(@driver)
# end

Then(/^I should be on (Login|Purchases) page$/) do |page|
  page_obj = Object.const_get("#{page.gsub(" ", "")}Page").new(@driver)
  page_url = page_obj.page_half_url
  raise Exception, "You should be on #{page} page! You are on #{page_url}" unless @tallie_page.on_right_page? page_url

end

Then(/^I stopped/) do
  puts "Just stop!"
end