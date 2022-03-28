# frozen_string_literal: true

require 'dry-initializer'
require_relative 'cronmon/version'
require_relative 'cronmon/rake_hooks'
require_relative 'helpers/rake_hooks_helpers'

module Cronmon
  class Error < StandardError; end
  # Your code goes here...
end
