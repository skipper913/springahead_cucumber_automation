

class TallieEnterpriseAccount
  attr_accessor :logged_in_employee, :enterprise_name, :usage

  def initialize(enterprise_name = nil, usage = 'DefaulEnterprise', employees = {})
    @enterprise_name = enterprise_name
    @usage = usage
    load_enterprise_info

    @employees = employees
    load_employees
    @logged_in_employee = {name: nil, email: nil, password: nil}
  end

  def default_employee
    @employees['DefaultEmployee']
  end
  def default_employee_email
    default_employee['Email']
  end

  def default_employee_password
    default_employee['Password']
  end

  def default_employee_name
    default_employee['Name']
  end

  def load_enterprise_info
      @enterprise_name = load_enterprise_name if @enterprise_name.nil?
  end

  def enterprise_data
      LOADED_TALLIE_ACCOUNTS[@usage]
  end

  def load_enterprise_name
      enterprise_data['Name']
  end


  def load_employees
    @employees = employees_data if @employees.empty?
  end

  def employees_data
      enterprise_data['Employees']
  end

  def employee_data(employee_type)
      employees_data[employee_type]
  end
end

