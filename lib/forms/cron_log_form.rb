# frozen_string_literal: true

require 'dry-initializer'

# The main responsibility fo this class to create/udpate cron log records
# Used dry initalizer for dry validaing params
module Forms
  class CronLogForm
    extend Dry::Initializer[undefined: false]

    option :id, optional: true
    option :cron_id, optional: true
    option :job_id, optional: true
    option :error_log, optional: true
    option :started_at, optional: true
    option :ended_at, optional: true

    def save
      find_or_create_record
      assign_attributes
      @record.save!

      @record
    end

    def assign_attributes
      @record.assign_attributes(
        cron_id: cron_id || @record.cron_id,
        job_id: job_id || @record.job_id,
        error_log: error_log || @record.error_log,
        started_at: started_at || @record.started_at,
        ended_at: ended_at || @record.ended_at
      )
    end

    def find_or_create_record
      @record = id.present? ? CronLog.find(id) : CronLog.new
    end
  end
end