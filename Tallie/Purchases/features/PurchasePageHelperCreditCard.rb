module PurchasePageHelperCreditCard
  ## CC
  IMPORT_CC_EXPENSE_BUTTON = {css: '.btn.btn-with-icon.btn-new-expense-cc.action-create-ccitem'}
  TRANSACTION_MODAL = {id: 'transaction-modal'}
  CC_SELECT_LIST = {css: '.cc-brand-select.action-trigger-change'}
  CC_OPTIONS = {tag_name: 'option'}

  def open_cc_popup
    click IMPORT_CC_EXPENSE_BUTTON
    wait_for(5) { is_displayed? TRANSACTION_MODAL }
  end

  def cc_listed?(bank_name)
    bank_name = bank_name.downcase + ' - '
    1.upto(3) do
      cc_options.each do |option|
        return true if option.text.downcase.include? bank_name
      end
      sleep 1
    end
    return false
  end

  def cc_should_be_listed(bank_name)
    raise Exception, "#{bank_name} should be listed!" unless cc_listed? bank_name
  end

  def cc_options
    find_elements CC_OPTIONS
  end

end