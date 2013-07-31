class AddSceneNumberToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :scene_number, :string
  end
end
