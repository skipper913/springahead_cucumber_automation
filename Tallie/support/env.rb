puts "*** in Tallie/support/env!! "

require 'watir-webdriver'
#require 'watir-webdriver/extensions/wait'


#if ENV["BROWSER"] == 'FireFox'
  browser = Watir::Browser.new :firefox
  WEBDRIVER = true
#end

Before do
  @browser = browser
end

at_exit do
  browser.close
end
