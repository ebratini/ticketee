class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates :role, inclusion: { in: %w[viewer editor manager],
    message: "%{value} is not a valid role" }
end
