# frozen_string_literal: true

require 'pry'

# created seperated module to add more such actions around perdorm method of sidekiq
module ClassMethods

  def around_perform(*filters, &blk)
    set_callback(:perform, :around, *filters, &blk)
  end

end
