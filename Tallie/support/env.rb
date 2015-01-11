require 'selenium-webdriver'
require 'require_all'

if ENV['base_url'].include? 'alpha'
  ENV['env'] = 'alpha'
else
  ENV['env'] = 'production'
end

driver = Selenium::WebDriver.for ENV['browser'].to_sym

Before do
  @driver = driver
end

After do
  driver.quit
end
# at_exit do
#   #@driver.close
#   driver.quit
#   #BrowserUtilities.close_all_browsers
# end
