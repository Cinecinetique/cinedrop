class Payment < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :worker
end
