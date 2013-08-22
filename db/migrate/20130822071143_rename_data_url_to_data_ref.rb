class RenameDataUrlToDataRef < ActiveRecord::Migration
  def change
  	rename_column :documents, :data_url, :data_ref
  end
end
