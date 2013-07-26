class RemoveKindColumnFromDocuments < ActiveRecord::Migration
  def change
  	remove_column :documents, :kind, :string
  end

end
