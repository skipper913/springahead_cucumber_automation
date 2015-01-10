#TODO - Refactor

def set_random_value_to_expense_attributes(attributes)
  if (attributes.has_key? 'merchant')
    attributes['merchant'] = purchases_page.auto_generate_merchant if attributes['merchant'].downcase.include? 'any text'
  end
  if (attributes.has_key? 'reason')
    attributes['reason'] = purchases_page.auto_generate_reason if attributes['reason'].downcase.include? 'any text'
  end
  if (attributes.has_key? 'reason_itemize')
    attributes['reason_itemize'] = purchases_page.auto_generate_reason if attributes['reason_itemize'].downcase.include? 'any text'
  end
  if attributes.has_key? 'amount'
    attributes['amount'] = purchases_page.auto_generate_amount if attributes['amount'].downcase.include? 'any'
  end
  if attributes.has_key? 'amount_itemize'
    if attributes['amount_itemize'].class == String
      attributes['amount_itemize'] = purchases_page.auto_generate_amount if attributes['amount_itemize'].downcase.include? 'any'
    end
  end
  attributes['date'] = purchases_page.any_past_date
  return attributes
end