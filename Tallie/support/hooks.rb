
Before do
  LOADED_TALLIE_ACCOUNTS = YAML.load_file("../support/test_data/#{ENV['env']}/tallie_accounts.yml")
end

Before('@Tallie-credit_card, @Tallie-purchases') do
  ##TODO: Remove login steps if we can bypass login
  require(File.join(FileUtilities.step_definitions_dir_absolute_path('login'), 'login_steps'))
  FileUtilities.require_files_in_dir(FileUtilities.pages_dir_absolute_path('login'))
end

Before('@Tallie-credit_card') do
  FileUtilities.require_files_in_dir(FileUtilities.pages_dir_absolute_path('purchases'))
  require_relative '../Purchases/features/step_definitions/import_cc_steps'
end

Before('@Tallie-login') do
  FileUtilities.require_files_in_dir(FileUtilities.pages_dir_absolute_path('purchases'))
end
