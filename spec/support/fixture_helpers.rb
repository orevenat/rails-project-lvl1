# frozen_string_literal: true

module FixtureHelpers
  def load_fixture(filename)
    File.read(File.dirname(__dir__) + "/fixtures/#{filename}").chop
  end
end
