class Document < ActiveRecord::Base
	has_attached_file :data, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
