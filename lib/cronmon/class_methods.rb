# frozen_string_literal: true

require 'pry'

module ClassMethods

  def around_perform(*filters, &blk)
    set_callback(:perform, :around, *filters, &blk)
  end

end
