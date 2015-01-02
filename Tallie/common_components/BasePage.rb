require_relative '../common_components/DriverHelper'

class BasePage
  include DriverHelper

  def initialize(driver)
    @driver = driver
  end

  def visit(url_path)
    @driver.get ENV['base_url'] + url_path
    #@driver.goto(ENV['base_url'] + url_path)
  end

  def find(locator)
    @driver.find_element locator
  end

  def find_elements(locator)
    @driver.find_elements locator
  end

  def type(text, locator)
    find(locator).send_keys text
  end

  def submit(locator)
    find(locator).submit
  end

  def click(locator)
    find(locator).click
  end

  def is_displayed?(locator)
    elements = find_elements(locator)
    if elements.size > 0
      elements[0].displayed?
    else
      false
    end
  end

  def is_exists?(locator)
    find_elements(locator).size > 0
  end

  def wait_for(seconds = 15)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end

  def text(locator)
    find(locator).text
  end

  def see_text?(text, locator = nil, *options)
    if locator.nil?
      text_displayed = @driver.text
    else
      text_displayed = text(locator)
    end
    if options.empty?
      text_displayed.include? text
    elsif options[:exact]
      text_displayed.eql? text
    else
      raise Exception, "Unknown options! options: #{options.inspect}"
    end
  end

  def select_list(text, locator)
    Selenium::WebDriver::Support::Select.new(find(locator)).select_by(:text, text)
  end

  def on_right_page?(partial_url)
    1.upto(30) do
      return true if @driver.current_url.downcase.include? partial_url.downcase
    end
    return false
  end

  def try_upto(times, second, condition, *params_to_condition)
    i = 0
    condition_met = false
    params_to_condition.each do
      condition += " params_to_condition[#{i}]"
      i+= 1
    end
    1.upto(times) do
      begin
        if eval("#{condition}")
          condition_met = true
          break
        end
        yield
        sleep second
      rescue
        yield
      end
    end
    return condition_met
  end


end