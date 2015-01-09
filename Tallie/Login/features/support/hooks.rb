## Add login specific hooks here

Before('@Tallie-login') do
  Dir["../purchases/features/pages/*.rb"].each { |file|
    load file
    puts "** file: #{file}"
  }
 # require_relative '../purchases/features/step_definitions/import_cc_steps'
end