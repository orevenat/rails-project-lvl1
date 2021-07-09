# frozen_string_literal: true

require 'hexlet_code/version'
require 'hexlet_code/tag'

module HexletCode
  class Error < StandardError; end

  def self.form_for(_object, url: '#', &_block)
    "<form action=\"#{url}\" method=\"post\">
    </form>"
  end
end
