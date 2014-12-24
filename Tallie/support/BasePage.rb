class BasePage
  def initialize(browser)
    @browser = browser
    @selenium_driver = @browser.driver
  end

  def visit(url_path)
    @selenium_driver.get ENV['base_url'] + url_path
  end

  def find(locator)
    @selenium_driver.find_element locator
  end

  def type(text, locator)
    find(locator).send_keys text
  end

  def submit(locator)
    find(locator).submit
  end

  def is_displayed?(locator)
    find(locator).displayed?
  end
end