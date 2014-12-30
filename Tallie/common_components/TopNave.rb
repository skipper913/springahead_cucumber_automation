
module TopNav
  TOP_NAV_HEADER_ACCOUNT_NAME = {class: 'header-name'}
  TOP_NAV_HEADER_COMPANY = {class: 'header-company'}

  def employee_name_displayed
    text(TOP_NAV_HEADER_ACCOUNT_NAME)
  end

  def enterprise_name_displayed
    text(TOP_NAV_HEADER_COMPANY)
  end

  def should_see_valid_employee_name(name)
    name_displayed = employee_name_displayed
    puts "Employee name: #{name}, name_displayed: #{name_displayed}"
    raise Exception, "Employee name #{name} should be displayed on the page, but #{name_displayed} is displayed instead!" unless name_displayed.eql? name
  end

  def should_see_valid_enterprise_name(name)
    name_displayed = enterprise_name_displayed
    puts "Enterprise name: #{name}, name_displayed: #{name_displayed}"
    raise Exception, "Enterprise name #{name} should be displayed on the page, but #{name_displayed} is displayed instead!" unless name_displayed.eql? name
  end


end