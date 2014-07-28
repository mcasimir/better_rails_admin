require File.join(File.dirname(__FILE__), "decorators.rb")

RailsAdmin.config.reset
RailsAdmin.config.class_variable_set("@@system_models", [])
RailsAdmin::AbstractModel.reset

RailsAdmin.config.included_models = []
RailsAdmin.config.label_methods.unshift :admin_label

Dir[Rails.root.join("app/admin/**/*.rb")].each do |path|
  load path
end