
class BasePage
  def initialize(driver)
    @driver = driver
  end

  def visit(url_path)
    @driver.get ENV['base_url'] + url_path
  end

  def find(locator)
    @driver.find_element locator
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
    find(locator).displayed?
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

  def on_right_page?(partial_url)
    1.upto(30) do
        return true if @driver.current_url.downcase.include? partial_url.downcase
    end
    return false
  end

  def try_upto(times, second, condition, *params_to_condition)
    i = 0
    params_to_condition.each do
      condition += " params_to_condition[#{i}]"
      i+= 1
    end
    1.upto(times) do
      break if eval("#{condition}")
      yield
      sleep second
    end
  end


end