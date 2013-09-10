class Scene < ActiveRecord::Base
  belongs_to :project, inverse_of: :scenes
  acts_as_list scope: :project
end
