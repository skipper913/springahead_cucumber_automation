require_relative '../common_components/browser_actions'

class TopNav
  TOP_NAV_HEADER_ACCOUNT_NAME = {class: 'header-name'}
  TOP_NAV_HEADER_COMPANY = {class: 'header-company'}
  TOP_NAV_ARROW_BUTTON = {css: '.toggle-identity.toggle-header-dropdown.header-identity-hide'}  #TODO need an id
  TOP_NAV_SIGN_OUT = {link_text: 'Sign Out'} #TODO:** use other attribute to locate.
  TOP_NAV_DROPDOWN = {id: 'identity-dropdown'}

  include BrowserActions

  def initialize(driver)
    @driver = driver
    super(@driver)
    wait_for(30) { is_displayed? TOP_NAV_HEADER_ACCOUNT_NAME }
  end

  def employee_name_displayed
    text(TOP_NAV_HEADER_ACCOUNT_NAME)
  end

  def enterprise_name_displayed
    text(TOP_NAV_HEADER_COMPANY)
  end

  def should_see_valid_employee_name(name)
    name_displayed = employee_name_displayed
    puts "Employee name: #{name}, name_displayed: #{name_displayed}"
    raise Exception, "Employee name #{name} should be displayed on the page, but #{name_displayed} is displayed instead!" unless name_displayed.eql? name
  end

  def should_see_valid_enterprise_name(name)
    name_displayed = enterprise_name_displayed
    puts "Enterprise name: #{name}, name_displayed: #{name_displayed}"
    raise Exception, "Enterprise name #{name} should be displayed on the page, but #{name_displayed} is displayed instead!" unless name_displayed.eql? name
  end

  def sign_out
    try_upto(5, 0.5, "is_displayed?", TOP_NAV_DROPDOWN) {click TOP_NAV_ARROW_BUTTON}
    try_upto(3, 0.5, "!is_displayed?", TOP_NAV_DROPDOWN) {click TOP_NAV_SIGN_OUT}
    #   click TOP_NAV_SIGN_OUT
  end

end
