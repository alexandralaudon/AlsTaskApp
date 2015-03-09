class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates_presence_of :user_id, message: "can't be blank"
  validates_uniqueness_of :user_id, message: 'has already been added to this project'

  ROLE = ['Member', 'Owner']

end
