class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :projects, through: :memberships
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email

  has_secure_password

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def hidden
    stars = pt_token.length - 4
    "#{pt_token[0..3]}#{'*'*stars}"
  end


end
