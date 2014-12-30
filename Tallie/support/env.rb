require 'selenium-webdriver'

if ENV['base_url'].include? 'alpha'
  ENV['env'] = 'alpha'
else
  ENV['env'] = 'production'
end

driver = Selenium::WebDriver.for ENV['browser'].to_sym

Before do
  @driver = driver
end

at_exit do
  #@driver.close
  driver.quit
end
