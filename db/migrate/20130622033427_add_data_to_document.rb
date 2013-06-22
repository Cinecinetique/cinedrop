class AddDataToDocument < ActiveRecord::Migration
  def change
  	add_attachment :documents, :data
  end
end
