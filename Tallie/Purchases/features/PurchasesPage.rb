class PurchasesPage < TopNav

  ADD_EXPENSE_BUTTON = {css: '.btn.btn-with-icon.btn-new-expense.action-create-expense'} #TODO Need an id
  EXPENSE_POPUP = {id: 'expense'}
  MERCHANT_FIELD = {id: 'Merchant'}
  CATEGORY_TEXT_FIELD = {id: 's2id_autogen1'}  #TODO need to confirm if this id does not get updated.
  REASON_FIELD = {id: 'Text'}
  AMOUNT_FIELD = {id: 'Amount'}
  CREATE_BUTTON = {css: '#expense-form button[data-action=submit]'}

  def initialize(driver)
    super
    @driver = driver
    wait_for(30) { is_displayed? ADD_EXPENSE_BUTTON }
  end

  def page_half_url
    '/x9/Expense'
  end

  def popup_field_locators
    {'merchant' => MERCHANT_FIELD, 'category'=> CATEGORY_TEXT_FIELD, 'reason'=>  REASON_FIELD, 'amount' => AMOUNT_FIELD}
  end

  def display_create_expense_popup
    popup_displayed =  try_upto(5, 0.5, 'is_displayed?', EXPENSE_POPUP) {click ADD_EXPENSE_BUTTON}
    raise Exception, "Failed to open a expense popup tile by clicking New Expense button" unless popup_displayed
  end

  def add_via_popup(fields = {})
    display_create_expense_popup
    unless fields.empty?
      fields.each do |name, text|
        locator = popup_field_locators[name]
        if name.eql? 'category'
         sleep 1
         click CATEGORY_TEXT_FIELD

        else
          type(text, locator)
        end


      end
      fields['date'] = DateTime.now.strftime('%m/%d/%Y')
    end

    click CREATE_BUTTON
  end

  def have_expense(field_value = {})
    raise Exception, "field_value should be in hash: {'merchant' => 'Cucumber Auto', 'category' => 'AirFare',...}" unless field_value.class == Hash

  end

end