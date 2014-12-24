puts "** in Common Steps!!!!"




Given /^I am on (Purchases|Free Trial|Login) page$/ do |page_name|
  case page_name
    when 'Free Trial', 'Login'
      @tallie_page = Object.const_get("#{page_name.gsub(" ","")}Page").new(@browser)
    when 'Purchases'

    else
      raise Exception "Unknown page: #{page}!"
  end
end
