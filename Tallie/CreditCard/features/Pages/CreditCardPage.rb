
require_relative '../../page_helpers/CreditCardPageHelperDelete'

class CreditCardPage < BasePage
  ADD_CREDIT_CARD = {css: '#BankAccount button[data-action="add-bank-account"]'}
  CC_LIGHTBOX = {id: 'cc-account-lightbox'}
  BANK_NAME = {id: 'bank-name'}
  SIGN_IN = {css: '.cc-login-signin.btn.btn-success'}
  LOGIN = {id: 'LOGIN'}
  PASSWORD = {id: 'PASSWORD1'}
  NEXT_BUTTON = {css: '.pull-right input[data-action="submit-subaccts"]'}
  CONTINUE_BUTTON = {css: '.pull-right button[data-action="continue"]'}
  CC_LIST = {id: 'cc-list'}
  CCS = {class: 'cc'}

  include CreditCardPageHelperDelete

  def initialize(driver)
    @driver = driver
    @url_path = page_half_url.downcase
    super(driver, @url_path, ADD_CREDIT_CARD)
    @num_of_cc_before_add = 0
  end

  def page_half_url
    '/x9/BankAccount'
  end

  ## TODO: need to store cc info in test data to switch default CC
  ## TODO How do we assure that bank5 always exists?
  def add_cc(bank_name = 'dagbank', login = 'cc.bank5', password = 'bank5')
    @num_of_cc_before_add = ccs.size
    bank_name = bank_name.downcase
    click ADD_CREDIT_CARD
    wait_for(5) {is_displayed? CC_LIGHTBOX}
    select_bank(bank_name)
    sign_in(login, password)
    #check_non_reimbursable(bank_name)
  end

  def check_non_reimbursable(bank_name)
    wait_for(10) {is_displayed? CC_LIST}
    ccs.each do |cc|
      if cc.find_element(class: 'cc-brand').text.downcase.eql? bank_name
        check_box = cc.find_element(name: 'corporate')
         unless check_box.selected?
           check_box.click
           sleep 1
           break
         end
      end
    end
  end

  def ccs
    find_elements(CCS)
  end

  def sign_in(login, password)
    type(login, LOGIN)
    type(password, PASSWORD)
    type(:return,  SIGN_IN)
    wait_for(30) {is_displayed? NEXT_BUTTON}
    click NEXT_BUTTON
    wait_for(15) {is_displayed? CONTINUE_BUTTON}
    click CONTINUE_BUTTON
    wait_for(30) {is_displayed? CCS}
  end

  def select_bank(bank_name)
    type(bank_name, BANK_NAME)
    sleep 1
    type(:left, BANK_NAME)
    1.upto(2) do
      begin
        type(:down, BANK_NAME)
        type(:return, BANK_NAME)
        wait_for(20) {is_displayed? SIGN_IN}
        break
       rescue
       end
    end
  end

  def should_see_cc_added(bank_name)
    try_upto(3, 1, 'num_of_cc_increased_by_one') {num_of_cc_increased_by_one}
    raise Exception, "Failed to add #{bank_name} credit card! @num_of_cc_before_add: #{@num_of_cc_before_add}: current size: #{ccs.size}" unless num_of_cc_increased_by_one
    raise Exception, "New credit card was added, but unable to find the bank name!" unless has_cc? bank_name
  end

  def num_of_cc_increased_by_one
    (ccs.size - @num_of_cc_before_add) == 1
  end

  def has_cc?(bank_name)
    bank_name = bank_name.downcase
    ccs.each do |cc|
      return true if cc.find_element(class: 'cc-brand').text.downcase.eql? bank_name
    end
    return false
  end

end