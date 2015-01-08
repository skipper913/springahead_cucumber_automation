## Add login specific hooks here

Before('@Tallie-Login') do
  Dir["../Purchases/features/pages/*.rb"].each { |file|
    load file
    puts "** file: #{file}"
  }
 # require_relative '../Purchases/features/step_definitions/import_cc_steps'
end