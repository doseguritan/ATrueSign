Doorkeeper::JWT.configure do
  # HMAC with Rails secret_key_base
  token_payload do |opts|
    user = User.find(opts[:resource_owner_id])
    {
      iss: "a_true_sign",
      sub: user.id,
      iat: Time.current.to_i,
      exp: (Time.current + 1.day).to_i
    }
  end

  secret_key Rails.application.secret_key_base
  signing_method :HS256
end
