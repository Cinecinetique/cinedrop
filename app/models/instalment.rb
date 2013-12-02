class Instalment < ActiveRecord::Base
  belongs_to :subscription

  def self.status_hash(payment_status)
  	statuses = { :Completed => 0,
  				 :Denied => 1,
  				 :Processed => 2
  	}
  	statuses[payment_status.to_sym]
  end

end
