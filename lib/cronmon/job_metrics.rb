# frozen_string_literal: true

require_relative './sidekiq_callbacks'
require 'sidekiq'
require_relative '../jobs/sidekiq_monitor_schedule_job'
require 'pry'

module JobMetrics
  extend ActiveSupport::Concern

  included do
    prepend SidekiqCallbacks

    around_perform do |job, block|
      create_cron(job)
      create_cron_log(jid)
      schedule_sidekiq_monitor_job

      block.call

      update_cron_log
    rescue StandardError => err
      update_cron_log(err)
    end

    def create_cron_log(jid)
      @cron_log ||= CronLog.create(cron: @cron, started_at: Time.now, job_id: jid)
    end

    def create_cron(job)
      @cron ||= Cron.find_by(action: job.class.to_s)
    end

    def update_cron_log(err = nil)
      @cron_log.update(error_log: err, ended_at: Time.now)
    end

    def schedule_sidekiq_monitor_job
      time_period = @cron.average_time_period.seconds
      SidekiqMonitorScheduleJob.perform_in(time_period, @cron_log.id)
    end
  end
end

