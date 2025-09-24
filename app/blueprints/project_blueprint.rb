class ProjectBlueprint < Blueprinter::Base
  identifier :id
  # fields :name, :domain, :is_active, :created_at, :updated_at

  view :standard do
    fields :name, :status, :assignee_id
  end
end
