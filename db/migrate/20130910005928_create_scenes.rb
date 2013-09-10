class CreateScenes < ActiveRecord::Migration
  def change
    create_table :scenes do |t|
      t.belongs_to :project, index: true
      t.string :script_story
      t.string :script_video
      t.string :script_audio
      t.string :slugline
      t.integer :position

      t.timestamps
    end
  end
end
