# frozen_string_literal: true

require 'sidekiq'

# Job responsibiity is to perform job at avr.executoion time and update the log if it didnlt compelted in scheduled time.
class SidekiqMonitorScheduleJob
  include Sidekiq::Worker

  def perform(*args)
    cron_log_id = args[0]
    cron_log = CronLog.find_by(id: cron_log_id)
    return if cron_log.ended_at.present?

    cron_log.update(error_log: "Alert!!!Cron didn't completed in schedule time", ended_at: Time.now)
  end
end