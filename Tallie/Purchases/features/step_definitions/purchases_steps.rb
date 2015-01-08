

Given /^I (am on|go to) Purchases page$/ do |temp|
  step %q{I am logged in to Tallie} #TODO need to bypass login and go to purchases page
 # @current_page = PurchasesPage.new(@driver)
 # @purchases_page = @current_page
end

When(/^I add a new expense with below data by clicking New Expense button:$/) do |table|
  @added_expense_attributes = table.rows_hash
  purchases_page.add_via_popup(set_random_value_to_expense_attributes(@added_expense_attributes))
  puts "@added_expense_attributes: #{@added_expense_attributes.inspect}"
end

Then(/^the new expense tile is added on the page$/) do
  purchases_page.should_have_expense(@added_expense_attributes)
end

Then(/^Expense tile is saved with edits$/) do
  purchases_page.should_have_expense(@edit_expense_attributes)
end

When(/^I edit an expense as below:$/) do |table|
  ##TODO: Need to create expense (via db query, RestAPI, etc)
  @edit_expense_attributes = table.rows_hash
  purchases_page.add_via_popup if purchases_page.number_of_expenses == 0
  puts "@edit_expense_attributes: #{@edit_expense_attributes.inspect}"
  purchases_page.edit_any_expense(set_random_value_to_expense_attributes(@edit_expense_attributes))
end

When(/^I add below itemizations to an expense:$/) do |table|
  ##TODO: Need to create expense (via db query, RestAPI, etc)
  purchases_page.add_via_popup if purchases_page.find_expense_with_no_item.nil?
  @itemized_expense_attributes = table.rows_hash
  @itemized_expense_attributes = @itemized_expense_attributes.each do |item, attributes|
    @itemized_expense_attributes[item] = eval(attributes)
    set_random_value_to_expense_attributes(@itemized_expense_attributes[item])
  end
  purchases_page.add_item_to_any_expense_with_no_item(@itemized_expense_attributes)
end

Then(/^I delete all Purchases$/) do
  purchases_page.delete_all_purchases
end

##TODO: Refactor below
def set_random_value_to_expense_attributes(attributes)
  if (attributes.has_key? 'merchant')
    attributes['merchant'] = purchases_page.auto_generate_merchant if attributes['merchant'].downcase.include? 'any text'
  end
  if (attributes.has_key? 'reason')
    attributes['reason'] = purchases_page.auto_generate_reason if attributes['reason'].downcase.include? 'any text'
  end
  if (attributes.has_key? 'reason_itemize')
    attributes['reason_itemize'] = purchases_page.auto_generate_reason if attributes['reason_itemize'].downcase.include? 'any text'
  end
  if attributes.has_key? 'amount'
    attributes['amount'] = purchases_page.auto_generate_amount if attributes['amount'].downcase.include? 'any'
  end
  if attributes.has_key? 'amount_itemize'
    if attributes['amount_itemize'].class == String
      attributes['amount_itemize'] = purchases_page.auto_generate_amount if attributes['amount_itemize'].downcase.include? 'any'
    end
  end
  attributes['date'] = purchases_page.any_past_date
  return attributes
end

