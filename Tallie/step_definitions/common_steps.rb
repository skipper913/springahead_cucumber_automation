

Given /^I am on (Purchases|Free Trial|Login) page$/ do |page_name|
  case page_name
    when 'Free Trial', 'Login'
      @tallie_page = Object.const_get("#{page_name.gsub(" ","")}Page").new(@driver)
    when 'Purchases'

    else
      raise Exception "Unknown page: #{page_name}!"
  end
end


Then(/^I stopped/) do
  puts "Just stop!"
end