# frozen_string_literal: true

require 'active_support/callbacks'
require_relative './class_methods'

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
