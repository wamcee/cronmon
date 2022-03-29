# frozen_string_literal: true

require 'active_support/callbacks'
require_relative './class_methods'

# This module responsibility to add active support callbacks dynamically to sidekiq jobs perform method.
# Checks for run_callbacks boolean and add callbacks accordingly.
module SidekiqCallbacks
  extend ActiveSupport::Concern

  def self.prepended(base)
    base.include(ActiveSupport::Callbacks)

    base.define_callbacks :perform

    class << base
      prepend ClassMethods
    end
  end

  def perform(*args)
    if respond_to?(:run_callbacks)
      run_callbacks :perform do
        super(*args)
      end
    else
      super(*args)
    end
  end
end
