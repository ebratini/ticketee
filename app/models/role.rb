class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  def self.available_roles
    %w[viewer editor manager]
  end
  
  validates :role, inclusion: { in: self.available_roles,
                                message: "%{value} is not a valid role" }
end
