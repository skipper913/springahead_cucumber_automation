require_relative '../PurchasePageHelper'

class PurchasesPage < TopNav
  include PurchasePageHelper

  ADD_EXPENSE_BUTTON = {css: '.btn.btn-with-icon.btn-new-expense.action-create-expense'} #TODO Need an id
  EXPENSE_POPUP = {id: 'expense'}
  EXPENSE_CONTAINER = {css: '.grid-expense-container'}
  MERCHANT_FIELD = {id: 'Merchant'}
  CATEGORY_TEXT_FIELD = {id: 's2id_autogen1'} #TODO need to confirm if this id does not get updated.
  CATEGORY_LISTS = {css: '.select2-results-dept-0.select2-result.select2-result-selectable'}
  REASON_FIELD = {id: 'Text'}
  AMOUNT_FIELD = {id: 'Amount'}
  CREATE_BUTTON = {css: '#expense-form button[data-action=submit]'}

  ## Edit expense
  EDIT_BUTTON = {css: '.bottom-action.sprite.edit'}
  MERCHANT_NAME = {css: '.merchant.title'}
  EXPENSE_DATE = {css: '.date_input'}
  SAVE_BUTTON = {css: '.modal-body button[data-action=submit]'}
  ITEMIZE_LINK = {css: '.btn-itemize'}
  ADD_NEW_ITEM_LINK = {css: '.item-add-btn'}
  BILLABLE_CHECKBOX = {id:'billable'}

  ## Itemization modal
  TITLE_ITEMIZATION = {css: '.modal-title.title'}
  REASON_FIELD_ITEMIZATION = {id: 'Itemizations_0__Text'}
  AMOUNT_FIELD_ITEMIZATION = {id: 'Itemizations_0__Amount'}
  CLOSE_ITEM_VIEW = {css: '.btn.btn-link.view-toggle'}

  def initialize(driver)
    super
    @driver = driver
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
    popup_displayed = try_upto(5, 0.5, 'is_displayed?', EXPENSE_POPUP) { find(EDIT_BUTTON, expense).click }
    raise Exception, "Failed to open a expense popup tile by clicking edit expense button" unless popup_displayed
  end

  def display_itemization_popup
    popup_displayed = try_upto(5, 0.5, 'is_displayed?', ADD_NEW_ITEM_LINK) { click ITEMIZE_LINK }
    raise Exception, "Failed to open a expense popup tile by clicking New Expense button" unless popup_displayed
  end

  def expense_popup_field_locators
    {'merchant' => MERCHANT_FIELD, 'category' => CATEGORY_TEXT_FIELD, 'reason' => REASON_FIELD, 'amount' => AMOUNT_FIELD, 'reason_itemize' => REASON_FIELD_ITEMIZATION,
     'amount_itemize' => AMOUNT_FIELD_ITEMIZATION, 'date' => EXPENSE_DATE}
  end

  def add_via_popup(fields = {})
    display_create_expense_popup
    enter_expense_field(fields) unless fields.empty?
    click CREATE_BUTTON
  end

  def edit_any_expense(fields)
    expense = expense_container[0]
    display_edit_expense_popup(expense)
    enter_expense_field(fields, false)
    click SAVE_BUTTON
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
    itemizes.each_value do |attributes|
      num_of_item_to_add -= 1
      enter_expense_field(attributes, false)
      click ADD_NEW_ITEM_LINK if num_of_item_to_add > 0
    end
    sleep 1
    click SAVE_BUTTON
  end


  def enter_expense_field(fields, add_mode = true)
    fields.each do |name, text|
      name = name.downcase
      locator = expense_popup_field_locators[name]
      case name
        when 'category'
          click CATEGORY_TEXT_FIELD
          wait_for(5) { is_exists? CATEGORY_LISTS }
          categories = find_elements(CATEGORY_LISTS)
          categories.each do |category|
            if category.text.downcase.eql? text.downcase
              category.click
              break
            end
          end
        else
          fld = find(locator)
          fld.clear if !add_mode or name.eql? 'date'
          fld.send_keys text
      end
      sleep 0.5
    end
    #click TITLE_ITEMIZATION
    click CLOSE_ITEM_VIEW
    sleep 3
  end

  def expense_container
    find_elements(EXPENSE_CONTAINER)
  end

  def number_of_expenses
    expense_container.size
  end

  def should_have_expense(field_value = {})
    raise Exception, "No expense found with #{field_value.inspect}!" unless have_expense? field_value
  end

  def have_expense?(field_value = {})
    raise Exception, "field_value should be in hash: {'merchant' => 'Cucumber Auto', 'category' => 'AirFare',...}" unless field_value.class == Hash
    sleep 3
    expense_container.each do |expense|
      match = true
      displayed = expense.text.downcase
      puts "displayed: #{displayed}"
      field_value.each_value do |text|
        puts "text: #{text.downcase}"
        unless displayed.include? text.downcase
          match = false
          break
        end
      end
      return true if match
    end
    return false
  end


end