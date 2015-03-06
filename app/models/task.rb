class Task < ActiveRecord::Base
  belongs_to :project
  validates :description, :project_id, presence:true
end
