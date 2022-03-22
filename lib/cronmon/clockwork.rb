# frozen_string_literal: true

require 'clockwork'
require 'pry'


module Clockwork
  on(:before_run) do |event, _|
    puts "job_started: #{event}"
    true
  end

end
