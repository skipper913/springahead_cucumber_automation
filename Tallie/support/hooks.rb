
Before do
  LOADED_TALLIE_ACCOUNTS = YAML.load_file("../support/test_data/#{ENV['env']}/tallie_accounts.yml")
end

Before('@Tallie-CreditCard-Add, @Tallie-CreditCard-Delete') do
  Dir["../Purchases/features/pages/*.rb"].each { |file|
    load file
    puts "** file: #{file}"
  }
  require_relative '../Purchases/features/step_definitions/import_cc_steps'
end

# Before('@Tallie-Purchases') do
#   Dir["../Purchases/features/pages/*.rb"].each { |file|
#     load file
#     puts "** file: #{file}"
#   }
#
#   require_relative '../Purchases/features/step_definitions/import_cc_steps'
#
# end

