require_relative '../common_components/base_page_helper'
require_relative '../common_components/browser_actions'

class BasePage
  SIGNIN_BUTTON = {id: 'signin-btn-header'}

  include BrowserActions
  include BasePageHelper

  def initialize(driver, url_path = '', displayed_locator = SIGNIN_BUTTON)
    @driver = driver
    super @driver
    @base_page_url = ENV['base_url']
    @url_path = url_path
    @displayed_locator = displayed_locator
  end

  def visit
    url = @base_page_url + @url_path
    @driver.get url unless current_url.eql? url
    on_page
  end
end