# frozen_string_literal: true

module HexletCode
  class FormBuilder
    def initialize(obj)
      @obj = obj
      @elements = []
    end

    def result
      @elements.join
    end

    def input(attr_name, **options, &block) # rubocop:disable Metrics/MethodLength
      type = options.fetch(:as, :string)

      value = @obj.public_send(attr_name)
      opts = options.except(:as)

      label = HexletCode::Tag.build(:label, for: attr_name) { attr_name.capitalize }
      tag = if type == :text
              HexletCode::Tag.build(:textarea, name: attr_name, body: value, **opts, &block)
            else
              HexletCode::Tag.build(:input, name: attr_name, type: 'text', value: value, **opts, &block)
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
