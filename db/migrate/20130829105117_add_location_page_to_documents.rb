class AddLocationPageToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :location, :string
    add_column :documents, :page, :string
  end
end
