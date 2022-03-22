# frozen_string_literal: true

require "active_support/callbacks"
require_relative './class_methods'

module SidekiqCallbacks
  # include ClassMethods
  extend ActiveSupport::Concern

  def self.prepended(base)
    base.include(ActiveSupport::Callbacks)

    base.define_callbacks :perform unless base.respond_to?(:_perform_callbacks) && base._perform_callbacks.present?

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
