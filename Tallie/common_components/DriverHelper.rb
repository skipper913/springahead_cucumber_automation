
module DriverHelper

  # def highlight(locator, ancestors=0)
  #   element = find(locator)
  #   @driver.execute_script("var hlt = function(c) { c.style.border='solid 1px rgb(255, 16, 16)'; }; return hlt(arguments[0]);", element)
  #   parents = ""
  #   red = 255
  #
  #   ancestors.times do
  #     parents << ".parentNode"
  #     red -= (12*8 / ancestors)
  #     execute_script("hlt = function(c) { c#{parents}.style.border='solid 1px rgb(#{red}, 0, 0)'; }; return hlt(arguments[0]);", element)
  #   end
  # end
end