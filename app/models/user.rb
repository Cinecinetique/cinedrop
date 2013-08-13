class User < ActiveRecord::Base
  validates :email, presence: true, :uniqueness => { :case_sensitive => false }
  has_secure_password
  has_many :workers, dependent: :destroy
  accepts_nested_attributes_for :workers, :allow_destroy => true
end
