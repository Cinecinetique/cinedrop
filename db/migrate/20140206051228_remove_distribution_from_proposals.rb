class RemoveDistributionFromProposals < ActiveRecord::Migration
  def up
  	change_table :proposals do |t|
	  	  t.remove :distribution
	 end
  end

   def down
	    change_table :proposals do |t|
  	  	  t.text :distribution
	  	 end
    end
end
