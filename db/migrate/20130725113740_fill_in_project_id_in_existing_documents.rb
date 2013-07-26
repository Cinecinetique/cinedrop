class FillInProjectIdInExistingDocuments < ActiveRecord::Migration
  def up
  	Document.all.each do |doc|
  		if doc.project_id.nil?
	  		doc.project_id = 1
	  		doc.save!
	  	end
  	end
  end

  def down
  	Document.where("project_id = 1").each do |doc|
  		doc.project_id = nil
  		doc.save!
  	end
  end
end
