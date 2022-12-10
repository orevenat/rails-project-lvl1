# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :Tag, 'hexlet_code/tag'

  class Error < StandardError; end

  def self.form_for(object, url: '#', &block)
    form = HexletCode::FormBuilder.new(object)
    yield form if block_given?
    "<form action=\"#{url}\" method=\"post\">#{form.result}</form>"
  end
end
