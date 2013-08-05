class AddCreatedByToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :created_by, :integer
  end
end
