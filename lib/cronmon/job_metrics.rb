# frozen_string_literal: true

require_relative './sidekiq_callbacks'
module JobMetrics
  extend ActiveSupport::Concern

  included do
    prepend SidekiqCallbacks

    around_perform do |_job, block|
      puts 'JOb finished finalyy!!!'
    end
  end
end
