
class LoginPage < BasePage

  USERNAME_INPUT = {id: 'Email'}
  PASSWORD_INPUT = {id: 'Password'}
  SUBMIT_BUTTON = {class: 'btn btn-success'}
  SIGN_IN_H2 = {class: 'login-icon'}  ## Unable to find a good page element locator.  Ask dev to add an id to the h2 tag

  def initialize(browser)
    super
    @selenium_driver = @browser.driver
    visit(page_half_url)
    @browser.wait_until(30, 'Timed out!Unable to get to Login page!') {@selenium_driver.find_element(SIGN_IN_H2).displayed?}
  end

  def page_half_url
    #TODO: set domain name in ENV variable
    '/sso/Account/Logon'
  end

  # def visit
  #   @browser.goto(page_url)
  # end

  def login(email = 'midori@springahead.com', password = 'Gomidogogo7711')
    #TODO: Move valid user account to account yml file
    #TODO: Need think about how we can ensure the account exists?

    type(email, USERNAME_INPUT)
    @selenium_driver.find_element(PASSWORD_INPUT).set password
    @selenium_driver.find_element(SUBMIT_BUTTON).click
  end

end