class ResourceController < ActionController::API
  before_action :doorkeeper_authorize!
  before_action :set_current_tenant

  private

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  def set_current_tenant
    org_id = request.headers["X-Organization-ID"]

    if org_id.blank?
      render json: { error: "Missing X-Organization-ID header" }, status: :bad_request and return
    end

    org = current_user.organizations.find_by(id: org_id, is_active: true)
    if org.nil?
      render json: { error: "Unauthorized for this organization" }, status: :forbidden and return
    end

    ActsAsTenant.current_tenant = org
  end

  def render_error(message)
    render json: { message: message }, status: :unprocessable_content
  end

  def render_success(message)
    render json: { message: message }, status: :ok
  end
end
