class PurchasesPage < BasePage
  include TopNav

  ADD_EXPENSE_BUTTON = {css: '.btn.btn-with-icon.btn-new-expense.action-create-expense'} #TODO Need an id
  EXPENSE_POPUP = {id: 'expense'}
  MERCHANT_FIELD = {id: 'Merchant'}
  CATEGORY_DROPDOWN = {id: 'edit-expense-category'}
  REASON_FIELD = {id: 'Text'}
  AMOUNT_FIELD = {id: 'Amount'}

  def initialize(driver)
    super
    @driver = driver
    visit(page_half_url)
    wait_for(30) { is_displayed? ADD_EXPENSE_BUTTON }
  end

  def page_half_url
    '/x9/Expense'
  end

  def add_via_popup(fields = {})
    popup_field_locators = {'merchant' => MERCHANT_FIELD, 'category' => CATEGORY_DROPDOWN, 'reason' => REASON_FIELD, 'amount' => AMOUNT_FIELD}
    popup_displayed =  try_upto(5, 0.5, 'is_displayed?', EXPENSE_POPUP) {click ADD_EXPENSE_BUTTON}
    raise Exception, "Failed to open a expense popup tile by clicking New Expense button" unless popup_displayed
    unless fields.empty?
      fields.each do |name, value|
        locator = popup_field_locators[name]
        fill_expense_popup(name, locator, value)
      end
    end
  end

  def fill_expense_popup(name, locator, text)
      if name.eql? 'category'

      else
        type(text, locator)
      end
  end
end