class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  STATUSES = {
  		"trial" => 0,
  		"paid" => 1,
  		"expired" => 2,
  		"terminated" => 3
  }

end
