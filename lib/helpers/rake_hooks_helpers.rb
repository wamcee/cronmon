# frozen_string_literal: true

require 'pry'

module RakeHooksHelpers

  def add_cron_hooks
    current_task = ARGV.first

    return unless current_task.include?('schedule')

    Rake::Task[current_task].enhance [:before_hook, :after_hook]

    # begin
    #   Rake::Task[current_task].invoke
    # rescue StandardError => err
    #   # Do something over here
    # end

    Rake::Task[current_task].invoke
  end
end
