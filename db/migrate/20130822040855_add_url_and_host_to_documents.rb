class AddUrlAndHostToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :data_url, :string
    add_column :documents, :data_host, :string
  end
end
