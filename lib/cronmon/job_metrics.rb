# frozen_string_literal: true

require_relative './sidekiq_callbacks'
require 'pry'

module JobMetrics
  extend ActiveSupport::Concern

  included do
    prepend SidekiqCallbacks

    around_perform do |job, block|
      cron = Cron.find_by(action: job.class.to_s)
      @cron_log = CronLog.create(cron: cron, started_at: Time.now, job_id: jid)
      block.call
      @cron_log.update(ended_at: Time.now)
    rescue StandardError => e
      @cron_log.update(error_log: e, ended_at: Time.now)
    end
  end
end
