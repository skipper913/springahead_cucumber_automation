
Before('@Tallie-login, @Tallie-Purchases') do
  LOADED_TALLIE_ACCOUNTS = YAML.load_file("../support/test_data/#{ENV['env']}/tallie_accounts.yml")
end

