class AdminCrudController < ResourceController
  include Pagy::Backend

  before_action :process_model

  def index
    render_list
  end

  def create
    @model.create(resource_params)
    render_success("Record has been successfully created")
  rescue => e
    render_error(e.message)
  end

  def update
    @model.update(resource_params)
    render_success("Record has been successfully updated.")
  rescue => e
    render_error(e.message)
  end

  def destroy
    # if resource_to_destroy.respond_to?(:destroy_all)
    #   resource_to_destroy.destroy_all
    # else
    #   resource_to_destroy.destroy
    # end
    render_success("Record/s has been successfully deleted.")
  rescue => e
    render_error(e.message)
  end

  private
  def process_model
    @model = ModelCustomParser.new(params[:controller])
  end

  def resource_model
    @model.model
  end

  def resource_params
    raise "Must be present"
  end

  def resource_blueprint
    blueprint = "#{@model.model_class}Blueprint".safe_constantize
    Rails.logger.warn "#-->>#{blueprint} must have a view :standard" unless blueprint.view?(:standard)
    blueprint
  end

  def resource
    @resource ||= resource_model.find(params[:id])
  end

  def resource_to_destroy
    if params[:ids]
      resource_model.where(id: params[:ids])
    else
      resource
    end
  end

  def custom_index_query
    resource_model.all.order(id: :asc)
  end

  def render_list
    pagy, records = pagy(custom_index_query)
    render json: resource_blueprint.render(records,
            view: :standard,
            root: :data,
            meta: pagy_metadata(pagy).slice(:page, :count, :limit, :pages)
          ),
          status: :ok
  rescue => e
    render_error(e.message)
  end
end
