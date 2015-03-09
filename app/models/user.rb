class User < ActiveRecord::Base
  has_many :memberships
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email

  has_secure_password

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end


end
