Before do
  LOADED_TALLIE_ACCOUNTS = YAML.load_file("../support/test_data/#{ENV['env']}/tallie_accounts.yml")

  ## loading page class here, because unable to added it to cucumber runner option as pages/*.rb
  FileUtilities.require_page_class
end

Before('@Tallie-credit_card, @Tallie-purchases') do
  ##TODO: Remove login steps if we can bypass login
  require_all FileUtilities.step_definitions_directory_path('login')
  FileUtilities.require_page_class('login')
end

Before('@Tallie-credit_card') do
  FileUtilities.require_page_class('purchases')
  require_relative '../Purchases/features/step_definitions/import_cc_steps'
end

Before('@Tallie-login') do
  FileUtilities.require_page_class('purchases')
end


