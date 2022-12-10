# frozen_string_literal: true

module HexletCode
  class FormBuilder
    def initialize(obj)
      @obj = obj
      @elements = []

      self
    end

    def result
      @elements.join('')
    end

    def input(attribute_name, **options, &block)
      type = options.fetch(:as, :string)

      value = @obj.public_send(attribute_name)

      label = HexletCode::Tag.build(:label, for: attribute_name) { attribute_name.capitalize }
      tag = if type == :text
              HexletCode::Tag.build(:textarea, name: attribute_name, body: value, **options.except(:as), &block)
            else
              HexletCode::Tag.build(:input, name: attribute_name, type: 'text', value: value, **options.except(:as), &block)
            end


      @elements << label
      @elements << tag
    end

    def submit(text = nil)
      value = text.nil? ? 'Save' : text
      tag = HexletCode::Tag.build(:input, type: 'submit', value: value)
      @elements << tag
    end
  end
end