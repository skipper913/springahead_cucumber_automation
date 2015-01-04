module CreditCardPageHelperDelete
  DELETE_ICON = {css: '.cc-action.cc-delete'}

  def delete_all
    stop = false
    max_try = 5
    count = 0
    unless (stop or count > max_try)
      count += 1
      delete_icons.each do |icon|
        icon.click
        sleep 3
      end
      number_of_delete_icons_left = delete_icons.length
      puts "number_of_delete_icons_left: #{number_of_delete_icons_left}"
      stop = true if number_of_delete_icons_left == 0
    end
  end

  def delete_icons
    find_elements DELETE_ICON
  end
end