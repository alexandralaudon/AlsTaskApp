class Membership < ActiveRecord::Base
  ROLE = ['Member', 'Owner']
  
  belongs_to :user
  belongs_to :project
  validates_presence_of :user_id, message: "can't be blank"
  validates_uniqueness_of :user_id, {scope: :project_id, message: 'has already been added to this project'}
  validates :role, presence: true, inclusion:ROLE


end
