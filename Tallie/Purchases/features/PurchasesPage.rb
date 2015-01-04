require_relative '../PurchasePageHelper'
require_relative '../features/PurchasePageHelperCreditCard'

class PurchasesPage < TopNav
  include PurchasePageHelper

  ADD_EXPENSE_BUTTON = {css: '.btn.btn-with-icon.btn-new-expense.action-create-expense'} #TODO Need an id
  EXPENSE_POPUP = {id: 'expense'}
  EXPENSE_CONTAINER = {css: '.grid-expense-container'}
  MERCHANT_FIELD = {id: 'Merchant'}
  CATEGORY_SEARCH_FIELD = {class: 'select2-search-field'} #id: 's2id_autogen1' changes

  #CATEGORY_LIST = {id: 's2id_expense-category-list'}
  CATEGORY_LIST_ITEMS = {css: '.select2-results-dept-0.select2-result.select2-result-selectable'}
  REASON_FIELD = {id: 'Text'}
  AMOUNT_FIELD = {id: 'Amount'}
  CREATE_BUTTON = {css: '#expense-form button[data-action=submit]'}

  ## Edit expense
  EDIT_BUTTON = {css: '.bottom-action.sprite.edit'}
  MERCHANT_NAME = {css: '.merchant.title'}
  EXPENSE_DATE = {css: '.date_input'}
  SAVE_BUTTON = {css: '#expense-form button[data-action=submit]'}
  ITEMIZE_LINK = {css: '.btn-itemize'}
  ADD_NEW_ITEM_LINK = {css: '.item-add-btn'}
  BILLABLE_CHECKBOX = {id: 'billable'}

  ## Itemization modal
  TITLE_ITEMIZATION = {css: '.modal-title.title'}
  REASON_FIELD_ITEMIZATION = {id: 'Itemizations_0__Text'}
  AMOUNT_FIELD_ITEMIZATION = {id: 'Itemizations_0__Amount'}
  CLOSE_ITEM_VIEW = {css: '.btn.btn-link.view-toggle'}
  SAVE_BUTTON_ITEMIZATION = {css: '.modal-body button[data-action=submit]'}

  include PurchasePageHelperCreditCard

  def initialize(driver)
    super
    @driver = driver
    visit page_half_url unless on_right_page? page_half_url
    wait_for(30) { is_displayed? ADD_EXPENSE_BUTTON }
  end

  def page_half_url
    '/x9/Expense'
  end


  def display_create_expense_popup
    popup_displayed = try_upto(5, 0.5, 'is_displayed?', EXPENSE_POPUP) { click ADD_EXPENSE_BUTTON }
    raise Exception, "Failed to open a expense popup tile by clicking New Expense button" unless popup_displayed
  end

  def display_edit_expense_popup(expense)
    popup_displayed = try_upto(5, 1, 'is_displayed?', EXPENSE_POPUP) { find(EDIT_BUTTON, expense).click }
    sleep 1 # fields are disabled when the popup just opened
    raise Exception, "Failed to open a expense popup tile by clicking edit expense button" unless popup_displayed
  end

  def close_item_view
    close_view = try_upto(5, 0.5, '!is_displayed?', REASON_FIELD_ITEMIZATION) { click CLOSE_ITEM_VIEW }
    raise Exception, "Failed to close itemize view" unless close_view
  end

  def display_itemization_popup
    popup_displayed = try_upto(5, 0.5, 'is_displayed?', ADD_NEW_ITEM_LINK) { click ITEMIZE_LINK }
    raise Exception, "Failed to open a expense popup tile by clicking New Expense button" unless popup_displayed
  end

  def expense_popup_field_locators
    {'merchant' => MERCHANT_FIELD, 'category' => CATEGORY_SEARCH_FIELD, 'reason' => REASON_FIELD, 'amount' => AMOUNT_FIELD, 'reason_itemize' => REASON_FIELD_ITEMIZATION,
     'amount_itemize' => AMOUNT_FIELD_ITEMIZATION, 'date' => EXPENSE_DATE}
  end

  def add_via_popup(fields = {})
    display_create_expense_popup
    fill_expense_popup(fields, false) unless fields.empty?
    #click CREATE_BUTTON
    find(SAVE_BUTTON).send_keys :return
    wait_for(5) { !is_displayed? EXPENSE_POPUP }
  end

  def edit_any_expense(fields)
    expense = expense_container[0]
    display_edit_expense_popup(expense)
    fill_expense_popup(fields)
    #click SAVE_BUTTON
    find(SAVE_BUTTON).send_keys :return
    wait_for(5) { !is_displayed? EXPENSE_POPUP }
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
    total_amount = 0
    itemizes.each_value do |item|
      num_of_item_to_add -= 1
      fill_expense_popup(item)
      total_amount += item['amount_itemize'].to_f if item.has_key?('amount_itemize')
      click ADD_NEW_ITEM_LINK if num_of_item_to_add > 0
    end
    sleep 1
    type(total_amount, AMOUNT_FIELD)
    click SAVE_BUTTON
  end


  def fill_expense_popup(fields, edit_mode = true)
    fields.each do |name, text|
      name = name.downcase
      locator = expense_popup_field_locators[name]
      case name
        when 'category'
          select_category(text)
        else
          enter_expense_popup_fields(name, text, locator, edit_mode)
      end
      sleep 0.5
      @driver.find_element(css: '.overlay.active').click
    end
  end

  def select_category(text)
    wait_for(5) {is_exists? CATEGORY_SEARCH_FIELD}
    click CATEGORY_SEARCH_FIELD
    wait_for(5) {(is_exists? CATEGORY_LIST_ITEMS) && (find(CATEGORY_SEARCH_FIELD).attribute('placeholder') != 'Searching')}
    categories = find_elements(CATEGORY_LIST_ITEMS)
    categories.each do |category|
      if category.text.downcase.eql? text.downcase
        category.click
        wait_for(5) { !is_exists? CATEGORY_LIST_ITEMS }
        break
      end
      sleep 1
    end
  end

  def enter_expense_popup_fields(field_name, text, locator, edit_mode = false)
    fld = find(locator)
    fld.clear if edit_mode or field_name.eql? 'date'
    fld.send_keys text
    sleep 0.5
    puts "stop"
  end

  def expense_container
    find_elements(EXPENSE_CONTAINER)
  end

  def number_of_expenses
    expense_container.size
  end

  def should_have_expense(attribute_values)
    raise Exception, "No expense found with #{attribute_values.inspect}!" unless have_expense? attribute_values
  end

  def have_expense?(attribute_values)
    raise Exception, "field_value should be in hash: {'merchant' => 'Cucumber Auto', 'category' => 'AirFare',...}" unless attribute_values.class == Hash
    sleep 1
    1.upto(6) do
      expense_container.each do |expense|
        match = true
        displayed = expense.text.downcase
        puts "EXPENSE: ******************************"
        puts "displayed: #{displayed}"
        attribute_values.each_value do |text|
          puts "Should display text: #{text.downcase}"
          unless displayed.include? text.downcase
            match = false
            break
          end
        end
        return true if match
      end
    end
    return false
  end

end