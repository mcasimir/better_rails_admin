require 'rails_admin'

RailsAdmin.module_eval do
  def model(name, &block)
    RailsAdmin.config.reset_model(name)
    system_models = RailsAdmin.config.class_variable_get("@@system_models")
    system_models << name unless system_models.include?(name)
    RailsAdmin.config.included_models << name unless RailsAdmin.config.included_models.include?(name)
    RailsAdmin.config.model(name, &block)
  end

  module_function :model
end

RailsAdmin::MainController.class_eval do
  
  before_filter :prevent_disabled_actions, except: RailsAdmin::Config::Actions.all(:root).collect(&:action_name)
  
  def prevent_disabled_actions
    if @abstract_model
      action = RailsAdmin::Config::Actions.find(action_name.to_sym)
      if action && action.except.include?(@abstract_model.model_name)
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end

end

RailsAdmin::ApplicationHelper.module_eval do
  def wording_for(label, action = @action, abstract_model = @abstract_model, object = @object)
    model_config = abstract_model.try(:config)
    object = abstract_model && object.is_a?(abstract_model.model) ? object : nil
    action = RailsAdmin::Config::Actions.find(action.to_sym) if action.is_a?(Symbol) || action.is_a?(String)

    I18n.t("admin.actions.#{action.i18n_key}.#{label}",
           model_label: model_config && model_config.label,
           model_label_plural: model_config && model_config.label_plural,
           object_label: model_config && object && model_config.object_label_proc.call(object)
          )
  end

  def authorized?(action_name, abstract_model = nil, object = nil)

    # authorization_key
    if abstract_model 
      action = RailsAdmin::Config::Actions.all.find {|a| a.authorization_key == action_name.to_sym }
      if action && action.except.include?(abstract_model.model_name)
        return false
      end
    end

    @authorization_adapter.nil? || @authorization_adapter.authorized?(action_name, abstract_model, object.try(:new_record?) ? nil : object)

  end
end

RailsAdmin::Config::Model.class_eval do
  
  def except(*args)
    configure_actions(:except, args)
  end

  def only(*args)
    configure_actions(:only, args)
  end

  def object_label_proc
    @label_proc || ->(object) {
      object.send(object_label_method)
    }
  end

  def object_label(&block)
    if block_given?
      @label_proc = block
    else
      self.object_label_proc.call(bindings[:object])
    end
  end

  private
  def configure_actions(mode, args)
    model = self.abstract_model.model_name.constantize
    registered_actions = RailsAdmin::Config::Actions.all
    registered_actions.each do |registered_action|
      should_be_excluded = args.map(&:to_s).include?(registered_action.action_name.to_s)
      should_be_excluded = !should_be_excluded if mode == :only
      if should_be_excluded
        except = registered_action.except
        unless except.include?(model.name)
          except << model.name
          registered_action.except except
        end
      end
    end
  end
end

RailsAdmin.config.label_methods.unshift :admin_label

ActionController::Base.class_eval do
  if Rails.env.development?
    before_filter do
      if controller_path =~ /^rails_admin\//
          load File.expand_path(File.join(File.dirname(__FILE__), "initializer.rb"))
      end
    end
  end
end
