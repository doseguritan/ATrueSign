class Api::V1::UsersController < ActionController::API
  before_action :doorkeeper_authorize!
  def organizations
    orgs = current_user.organizations.map { |org| { label: org.name, value: org.id.to_s } }
    render json: { data: orgs }, status: :ok
  end

  def profile
    render json: { profile: current_user }, status: :ok
  end

  private
  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end
end
