module OmniAuthHelpers
  def set_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '123456',
      :info => {
        :email => "John@test.com",
        :name => 'John'
      },
      :credentials => {
        :token => "mock_token",
        :expires_at => Time.now.to_i + 3600
      }
    })
  end
end