
class LoginPage < BasePage
  USERNAME_INPUT = {id: 'Email'}
  PASSWORD_INPUT = {id: 'Password'}
  SUBMIT_BUTTON = {css: '.btn.btn-success'}
  SIGN_IN_H2 = {class: 'login-icon'}

  def initialize(driver)
    url_path = '/sso/account/logon'
    @driver = driver
    displayed_locator = SIGN_IN_H2
    super(driver, url_path, displayed_locator)
  end

  def login_with(email, password)
    type(email, USERNAME_INPUT)
    type(password, PASSWORD_INPUT)
    submit SUBMIT_BUTTON
  end
end