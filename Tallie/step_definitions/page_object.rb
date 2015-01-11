module PageObject
  def top_nav
    @top_nav ||= TopNav.new(@driver)
  end

  def login_page
    @login_page ||= LoginPage.new(@driver)
  end

  def cc_page
    @cc_page ||= CreditCardPage.new(@driver)
  end

  def purchases_page
    @purchases_page ||= PurchasesPage.new(@driver)
  end
end

World(PageObject)
