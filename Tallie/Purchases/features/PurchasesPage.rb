require_relative '../PurchasePageHelper'

class PurchasesPage < TopNav
  include PurchasePageHelper

  ADD_EXPENSE_BUTTON = {css: '.btn.btn-with-icon.btn-new-expense.action-create-expense'} #TODO Need an id
  EXPENSE_POPUP = {id: 'expense'}
  MERCHANT_FIELD = {id: 'Merchant'}
  CATEGORY_TEXT_FIELD = {id: 's2id_autogen1'} #TODO need to confirm if this id does not get updated.
  CATEGORY_LISTS = {css: '.select2-results-dept-0.select2-result.select2-result-selectable'}
  REASON_FIELD = {id: 'Text'}
  AMOUNT_FIELD = {id: 'Amount'}
  CREATE_BUTTON = {css: '#expense-form button[data-action=submit]'}
  ## added expense
  EXPENSE_CONTAINER = {css: '.grid-expense-container'}
  MERCHANT_NAME = {css: '.merchant.title'}
  ## Edit expense
  EDIT_BUTTON = {css: '.bottom-action.sprite.edit'}
  EXPENSE_DATE = {name: 'ExpenseDate'}
  SAVE_BUTTON = {css: '#expense-form button[data-action=submit]'}

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

  def popup_field_locators
    {'merchant' => MERCHANT_FIELD, 'category' => CATEGORY_TEXT_FIELD, 'reason' => REASON_FIELD, 'amount' => AMOUNT_FIELD, 'date' => EXPENSE_DATE}
  end

  def add_via_popup(fields = {})
    display_create_expense_popup
    unless fields.empty?
      enter_expense_field(fields)
      # fields.each do |name, text|
      #   name = name.downcase
      #   locator = popup_field_locators[name]
      #   if name.eql? 'category'
      #     click CATEGORY_TEXT_FIELD
      #     wait_for(5) { is_exists? CATEGORY_LISTS }
      #     categories = find_elements(CATEGORY_LISTS)
      #     categories.each do |category|
      #       if category.text.downcase.eql? text.downcase
      #         category.click
      #         break
      #       end
      #     end
      #   else
      #     type(text, locator)
      #   end
      # end
    end
    #sleep 3
    click CREATE_BUTTON
  end

  def edit_any_expense(fields)
    expense = expense_container[0]
    open_edit_expense_popup(expense)
    enter_expense_field(fields, false)
    # fields.each do |name, text|
    #   name = name.downcase
    #   locator = popup_field_locators[name]
    #   case name
    #     when 'category'
    #       click CATEGORY_TEXT_FIELD
    #       wait_for(5) { is_exists? CATEGORY_LISTS }
    #       categories = find_elements(CATEGORY_LISTS)
    #       categories.each do |category|
    #         if category.text.downcase.eql? text.downcase
    #           category.click
    #           break
    #         end
    #       end
    #     else
    #       fld = find(locator)
    #       fld.clear
    #       fld.send_keys text
    #   end
    # end
    #sleep 3
    click SAVE_BUTTON
  end

  def enter_expense_field(fields, add_mode = true)
    fields.each do |name, text|
      name = name.downcase
      locator = popup_field_locators[name]
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
          fld.clear unless add_mode
          fld.send_keys text
      end
      sleep 0.5
    end
    sleep 3
  end

  def open_edit_expense_popup(expense)
    popup_displayed = try_upto(5, 0.5, 'is_displayed?', EXPENSE_POPUP) { find(EDIT_BUTTON, expense).click }
    raise Exception, "Failed to open a expense popup tile by clicking edit expense button" unless popup_displayed
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