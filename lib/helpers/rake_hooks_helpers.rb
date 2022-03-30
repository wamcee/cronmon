# frozen_string_literal: true

require_relative './cron_helper'

# This module is included in main rake file. So, be careful when you edit this file
# This adds the hook to rake task if the task is under schdeule namespace
module RakeHooksHelpers

  def add_cron_hooks
    current_task = ARGV.first

    return unless current_task&.include?('schedule')

    Rake::Task[current_task].enhance [:before_hook, :after_hook]

    begin
      Rake::Task[current_task].invoke
    rescue StandardError => e
      update_cron_log(e.message, Time.now)
    end

  end
end
