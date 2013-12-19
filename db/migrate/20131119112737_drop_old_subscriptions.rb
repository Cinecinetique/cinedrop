class DropOldSubscriptions < ActiveRecord::Migration
  def up
  	unless table_exists?(:subscriptions)
	  	drop_table :subscriptions
		end
  end

	def down
	  	raise ActiveRecord::IrreversibleMigration
	end

end
