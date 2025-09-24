# frozen_string_literal: true

Doorkeeper.configure do
  api_only
  orm :active_record

  resource_owner_authenticator do
    User.find_by(id: session[:user_id]) || redirect_to(new_user_session_url)
  end

  resource_owner_from_credentials do |_routes|
    user = User.find_for_database_authentication(email: params[:username])
    if user&.valid_password?(params[:password])
      user
    end
  end

  grant_flows %w[password authorization_code client_credentials refresh_token]
  use_refresh_token
  revoke_refresh_token_on_use = true
end
