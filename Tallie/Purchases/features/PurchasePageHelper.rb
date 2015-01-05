
module PurchasePageHelper
  def auto_generate_merchant
    range = [*'0'..'9', *'a'..'z', *'A'..'Z']
    range.sample(7).join + 'AUTO'
  end

  def auto_generate_reason
    "#{rand(100...1000)} - Automation"
  end

  def auto_generate_amount
    '%.2f' % (rand * 1000)
  end

end