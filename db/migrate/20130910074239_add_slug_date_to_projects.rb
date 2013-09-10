class AddSlugDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :slug, :string
    add_column :projects, :date, :datetime
  end
end
