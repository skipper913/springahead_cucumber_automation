
module PurchasePageHelperDelete
  DELETE_ICON = {css: '.bottom-action.sprite.delete'}
  def delete_all_purchases
    stop = false
    max_try = 5
    count = 0
    unless (stop or count > max_try)
      count += 1
      expense_container.each do |expense|
        expense.find_element(DELETE_ICON).click
        sleep 3
      end
      number_of_expense_container_left = expense_container.length
      puts "number_of_expense_container_left: #{number_of_expense_container_left}"
      stop = true if number_of_expense_container_left == 0
    end
  end
end