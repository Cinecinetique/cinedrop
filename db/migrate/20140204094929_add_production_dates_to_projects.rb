class AddProductionDatesToProjects < ActiveRecord::Migration
  def change
  	change_table :projects do |t|
  		t.date :preprod_start
  		t.date :preprod_end
  		t.date :prod_start
  		t.date :prod_end
  		t.date :postprod_start
  		t.date :postprod_end
  	end
  end
end
