module RailsAdmin
  class ModelGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    desc "Creates a RailsAdmin model"
    
    class_option :list, type: :array, default: []
    class_option :edit, type: :array, default: []
    class_option :only, type: :array, default: []
    class_option :except, type: :array, default: []
    class_option :nav, type: :string, default: ""

    def create_model_file
      template "model.rb.tt", File.join("app/admin", "#{file_name}_admin.rb")
    end
  end
end
