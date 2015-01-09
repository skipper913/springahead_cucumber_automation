
module PurchasesPageHelperItemization
  TITLE_ITEMIZATION = {css: '.modal-title.title'}
  REASON_FIELD_ITEMIZATION = {id: 'Itemizations_0__Text'}
  AMOUNT_FIELD_ITEMIZATION = {id: 'Itemizations_0__Amount'}
  CLOSE_ITEM_VIEW = {css: '.btn.btn-link.view-toggle'}
  SAVE_BUTTON_ITEMIZATION = {css: '.modal-body button[data-action=submit]'}
  ITEMIZE_LINK = {css: '.btn-itemize'}
  ADD_NEW_ITEM_LINK = {css: '.item-add-btn'}
  SAVE_BUTTON = {css: '.modal-buttons-right.clearfix button[data-action=submit]'}

  AMOUNT_FIELD = {id: 'Amount'}

  def close_item_view
    close_view = try_upto(5, 0.5, '!is_displayed?', REASON_FIELD_ITEMIZATION) { click CLOSE_ITEM_VIEW }
    raise Exception, "Failed to close itemize view" unless close_view
  end

  def display_itemization_popup
    popup_displayed = try_upto(5, 0.5, 'is_displayed?', ADD_NEW_ITEM_LINK) { click ITEMIZE_LINK }
    raise Exception, "Failed to open a expense popup tile by clicking New Expense button" unless popup_displayed
  end

  def find_expense_with_no_item
    expense_container.each do |item|
      return item unless item.text.downcase.match(/item(s)* added/)
    end
    return nil
  end

  def add_item_to_any_expense_with_no_item(itemizes)
    expense = find_expense_with_no_item
    raise "There is no expense w/o items." if expense.nil?
    display_edit_expense_popup(expense)
    display_itemization_popup
    num_of_item_to_add = itemizes.size
    total_amount = 10.00  ##TODO: If total is exact, it displays error for some reason.
    itemizes.each_value do |item|
      num_of_item_to_add -= 1
      fill_expense_popup(item)
      total_amount += item['amount_itemize'].to_f if item.has_key?('amount_itemize')
      click ADD_NEW_ITEM_LINK if num_of_item_to_add > 0
    end
    sleep 1
    find(AMOUNT_FIELD).click
    total_amount = '%.2f' % total_amount
    find(AMOUNT_FIELD).clear
    type(total_amount, AMOUNT_FIELD)
    click SAVE_BUTTON
    puts "test"
  end

end