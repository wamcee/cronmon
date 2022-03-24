# frozen_string_literal: true

require 'clockwork'
require 'pry'


module Clockwork
  on(:before_run) do |event, t|
    puts "job_started: #{event}"
    true
  end

  on(:after_run) do |event, t|
    puts "job_finished: #{event}"
  end

end
