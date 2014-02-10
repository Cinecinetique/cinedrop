class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  STATUSES = {
  		"trial" => -1,
  		"error" => 0,
  		"paid" => 1,
  		"expired" => 2,
  		"terminated" => 3,
  		"cancelled" => 4
  }

end
