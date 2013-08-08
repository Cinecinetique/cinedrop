class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.references :user, index: true
      t.belongs_to :project, index: true
      t.string :department
      t.string :company
      t.string :role

      t.timestamps
    end
  end
end
