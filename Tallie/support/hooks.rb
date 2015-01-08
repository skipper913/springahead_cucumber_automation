
Before do
  LOADED_TALLIE_ACCOUNTS = YAML.load_file("../support/test_data/#{ENV['env']}/tallie_accounts.yml")
end

Before('@Tallie-CreditCard, @Tallie-Purchases') do
  ##TODO: Remove login steps if we can bypass login
  require_relative '../Login/features/step_definitions/login_steps'
  require_relative '../Login/features/pages/LoginPage'
end

Before('@Tallie-CreditCard') do
  Dir["../Purchases/features/pages/*.rb"].each { |file|
    load file
    puts "** file: #{file}"
  }
  require_relative '../Purchases/features/step_definitions/import_cc_steps'
end

# Before('@Tallie-Purchases') do
#   Dir["../Purchases/features/page_helpers/*.rb"].each { |file|
#     load file
#     puts "** file: #{file}"
#   }
#
#   require_relative '../Purchases/features/step_definitions/import_cc_steps'
#
# end

