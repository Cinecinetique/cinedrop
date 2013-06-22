class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end
