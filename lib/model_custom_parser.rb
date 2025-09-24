class ModelCustomParser
  def initialize(controller_name)
    @controller = controller_name
    self.convert_controller_to_model
  end
  # check if the controller has the same model
  def convert_controller_to_model
    model_name = @controller.singularize.classify
    model_name.split("::").reduce(Object) do |namespace, name|
      return nil unless namespace.const_defined?(name)
      self.model_class = name
      self.model = namespace.const_get(name)
    end
  rescue NameError
    raise "Resource model #{model_name} not found"
  end
  # turn the model class name to blueprint
  def process_blueprinter_class
    clss = "#{@model_class}Blueprint".constantize
    self.blueprint = "#{@model_class}Blueprint".safe_constantize
    Rails.logger.warn "#{clss}, asdfsfd"
  end

  # for blueprint
  def blueprint
    @blueprinter
  end
  def blueprint=(printer)
    @blueprinter = printer
  end

  # for auto model
  def model
    @model
  end
  def model=(model)
    @model = model
  end

  def model_class
    @model_class
  end
  def model_class=(model)
    @model_class = model
  end
end
