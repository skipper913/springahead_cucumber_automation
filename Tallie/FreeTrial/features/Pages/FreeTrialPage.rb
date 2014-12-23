class FreeTrialPage
  def initialize(browser)
    @browser = browser

  end

  def page_url
    #TODO: set domain name in ENV variable
    'https://alpha-springaheadgo.com/free-trial-begin-expense-reports'
  end
  def visit
    @browser.goto(page_url)
  end

end