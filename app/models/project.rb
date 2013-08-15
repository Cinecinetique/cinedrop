class Project < ActiveRecord::Base
	has_many :documents
	has_many :workers, dependent: :destroy
	accepts_nested_attributes_for :workers, :allow_destroy => true
end
