class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :workers, dependent: :destroy
  accepts_nested_attributes_for :workers, :allow_destroy => true

  def projects
  	workers.map { |w| w.project }
  end

  def projects_created
    Project.where("created_by = #{id}")
  end

  def managed_users
    projects_teams = []

    projects_created.each do |project| 
      project.team.each { |member| projects_teams << member}
    end
    projects_teams.uniq
  end

  def position(project_id)
    if project_id
      Worker.where("user_id = #{id} and project_id = #{project_id}").first
    end
  end

  def can_admin?
  	is_admin
  end
end
