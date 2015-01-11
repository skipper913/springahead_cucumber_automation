module TallieUserData
  def tallie_enterprise_account
    @tallie_enterprise_account ||= TallieEnterpriseAccount.new
  end
end

World(TallieUserData)