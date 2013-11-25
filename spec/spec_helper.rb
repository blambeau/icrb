$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'icrb/full'
require_relative 'fixtures/color'

module SpecHelpers
end

RSpec.configure do |c|
  c.include SpecHelpers
end
