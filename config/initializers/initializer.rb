require File.join(File.dirname(__FILE__), "once.rb")

RailsAdmin.config.reset
RailsAdmin.config.class_variable_set("@@system_models", [])
RailsAdmin::AbstractModel.reset

RailsAdmin.config.included_models = []

load Rails.root.join("config/rails_admin.rb")

Dir[Rails.root.join("app/admin/**/*.rb")].each do |path|
  load path
end