# frozen_string_literal: true

require 'clockwork'

module ClockworkHooks

  module Clockwork
    on(:before_run) do |event, _|
      puts "job_started: #{event}"
    end
  end
end
