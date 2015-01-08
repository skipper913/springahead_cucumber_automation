module PageObject
  # def set_current_page(page)
  #   @current_page = page
  # end
  def top_nav
    @top_nav ||= TopNav.new(@driver)
  end

  def login_page
    @login_page ||= LoginPage.new(@driver)
 #   set_current_page @login_page
  end

  def cc_page
    @cc_page ||= CreditCardPage.new(@driver)
  #  set_current_page @cc_page
  end

  def purchases_page
    @purchases_page ||= PurchasesPage.new(@driver)
   # set_current_page @purchases_page
  end
end

World(PageObject)
