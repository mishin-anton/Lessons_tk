module Accessors

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attr_names)
      attr_names.each do |attr_name|
        attr_name = attr_name.to_s
        attr_hist_name = attr_name+'_history'

        self.module_eval("def #{attr_name};@#{attr_name};end")

        self.module_eval %Q{
          def #{attr_name}=(val)
            @#{attr_hist_name} = [nil] if @#{attr_hist_name}.nil?
            @#{attr_hist_name} << val

            @#{attr_name}=val
          end

          def #{attr_hist_name};@#{attr_hist_name};end
        }
      end
    end

    def strong_attr_accessor(name, type)
      define_method(name) do
        instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |value|
        if value.is_a? type
          instance_variable_set("@#{name}", value)
        else
          raise ArgumentError.new("Неверный тип")
        end
      end
    end
  end
end
