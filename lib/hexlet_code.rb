# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :Tag, 'hexlet_code/tag'

  class Error < StandardError; end

  def self.form_for(object, **options)
    form = HexletCode::FormBuilder.new(object)
    yield form if block_given?
    action = options.fetch(:url, '#')
    form_options = { action:, method: 'post' }.merge(options.except(:url))
    HexletCode::Tag.build('form', form_options) do
      form.result
    end
  end
end
