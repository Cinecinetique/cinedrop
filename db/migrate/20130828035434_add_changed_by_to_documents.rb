class AddChangedByToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :changed_by, :integer
  end
end
