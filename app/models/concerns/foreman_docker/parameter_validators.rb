module ForemanDocker
  module ParameterValidators
    extend ActiveSupport::Concern
    
    included do
      validate :validate_parameters_names
    end

    def validate_parameters_names
      names = []
      errors = false
      self.send(parameters_symbol).each do |param|
        next unless param.new_record? # normal validation would catch this
        if names.include?(param.name)
          param.errors[:name] = _('has already been taken')
          errors = true
        else
          names << param.name
        end
      end
      self.errors[parameters_symbol] = _('Please ensure the following parameters name are unique') if errors
    end

    def parameters_symbol
      return :environment_variables if is_a? Container
      super
    end
  end
end
