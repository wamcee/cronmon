# frozen_string_literal: true

require_relative '../forms/cron_log_form'

module CronHelper

  def add_cron_log(task_name)
    cron = Cron.find_or_create_by(name: task_name)
    create_hash = { cron_id: cron.id, started_at: Time.now }

    @cron_log = Forms::CronLogForm.new(create_hash).save
  end

  def update_cron_log(ended_at)
    update_hash = { id: @cron_log.id, ended_at: ended_at }
    Forms::CronLogForm.new(update_hash).save
  end
end
