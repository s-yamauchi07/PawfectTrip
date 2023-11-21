module OmniAuthHelpers
  def set_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '123546',
      :info => {
        :email => "John@test.com",
        :name => 'John'
      }
    })
  end
end