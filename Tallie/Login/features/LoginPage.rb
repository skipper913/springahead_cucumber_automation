class LoginPage < BasePage

  USERNAME_INPUT = {id: 'Email'}
  PASSWORD_INPUT = {id: 'Password'}
  SUBMIT_BUTTON = {css: '.btn.btn-success'}
  SIGN_IN_H2 = {class: 'login-icon'} ## Unable to find a good page element locator.  Ask dev to add an id to the h2 tag

  def initialize(driver)
    super
    @driver = driver
    #visit(page_half_url)
    wait_for(30) { is_displayed? SIGN_IN_H2 }
  end

  def page_half_url
    '/sso/Account/Logon'
  end

  def login_with(email, password)
    @email = email
    @password = password
    type(email, USERNAME_INPUT)
    type(password, PASSWORD_INPUT)
    submit SUBMIT_BUTTON
  end

  def with_valid_credentials
    login_with(@tallie_enterprise_account.default_employee_email, @tallie_enterprise_account.default_employee_password)
  end

end