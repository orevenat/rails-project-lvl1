# frozen_string_literal: true

module HexletCode
  class FormBuilder
    def initialize(obj, *args, &block)
      @obj = obj
      @options = args.detect { |opt| opt.is_a?(Hash) } || {}
      @args = args

      res = instance_eval &block

      binding.irb
      res.to_s
    end

    def input(name, options = {})
      input_type = options[:as] || 'text'
      HexletCode::Tag.build('input', type: input_type, value: 'Save')
    end

    private

    # def default_input_type(attribute)
    #   input_type = @object.try(:column_for_attribute, attribute)
    #   case input_type
    #     when nil then :string
    #     when :timestamp then :datetime
    #     else input_type
    #   end
    # end
  end
end
