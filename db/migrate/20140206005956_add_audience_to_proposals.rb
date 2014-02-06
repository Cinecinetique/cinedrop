class AddAudienceToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :audience, :text
  end
end
