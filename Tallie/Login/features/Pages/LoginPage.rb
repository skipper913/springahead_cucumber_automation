#
# class LoginPage < BasePage
#
#   USERNAME_INPUT = {id: 'Email'}
#   PASSWORD_INPUT = {id: 'Password'}
#   SUBMIT_BUTTON = {css: '.btn.btn-success'}
#   SIGN_IN_H2 = {class: 'login-icon'} ##TODO: Unable to find a good page element locator.  Ask dev to add an id to the h2 tag
#
#   def initialize(driver)
#     super
#     @driver = driver
#     visit(partial_url) unless on_right_page? partial_url
#     wait_for(30) { is_displayed? SIGN_IN_H2 }
#   end
#
#   def partial_url
#     '/sso/account/logon'
#   end
#
#   def login_with(email, password)
#     @email = email
#     @password = password
#     type(email, USERNAME_INPUT)
#     type(password, PASSWORD_INPUT)
#     submit SUBMIT_BUTTON
#   end
#
#   def with_valid_credentials
#     login_with(@tallie_enterprise_account.default_employee_email, @tallie_enterprise_account.default_employee_password)
#   end
#
# end

class LoginPage < BasePage
  USERNAME_INPUT = {id: 'Email'}
  PASSWORD_INPUT = {id: 'Password'}
  SUBMIT_BUTTON = {css: '.btn.btn-success'}
  SIGN_IN_H2 = {class: 'login-icon'} ##TODO: Unable to find a good page element locator.  Ask dev to add an id to the h2 tag

  def initialize(driver)
    url_path = '/sso/account/logon'
    @driver = driver
    displayed_locator = SIGN_IN_H2
    super(driver, url_path, displayed_locator)

   # visit(partial_url) unless on_right_page? partial_url
    #wait_for(30) { is_displayed? SIGN_IN_H2 }
    #@partial_url = '/sso/account/logon'
  end

  # def partial_url
  #   @partial_url = '/sso/account/logon'
  # end

  # def visit
  #   super(@partial_url)
  #   on_page
  #   #wait_for(30) { is_displayed? SIGN_IN_H2 }
  # end
  #
  # def on_page
  #   raise Exception, "Not on the right page! " unless on_right_page? @partial_url, SIGN_IN_H2
  # end

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