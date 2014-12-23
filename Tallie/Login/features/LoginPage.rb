class LoginPage

  USERNAME_INPUT = {id: 'Email'}
  PASSWORD_INPUT = {id: 'Password'}
  SUBMIT_BUTTON = {class: 'btn btn-success'}

  def initialize(browser)
    @browser = browser

  end

  def page_url
    #TODO: set domain name in ENV variable
    'https://alpha-springaheadgo.com/sso/Account/Logon'
  end
  def visit
    @browser.goto(page_url)
  end

  def login
    @browser.text_field(USERNAME_INPUT).set 'midori@springahead.com'
    @browser.text_field(PASSWORD_INPUT).set 'Gomidogogo7711'
    @browser.button(SUBMIT_BUTTON).click
  end

end