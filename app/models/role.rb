class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates role, inclusion: { in: %[:viewer, :editor, :manager] }
end
