class User < ApplicationRecord
   before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def role?(r)
    role.include? r.to_s
  end
  private
  def set_default_role
    self.role ||= 'normal'
  end
  def password_required?
    new_record? ? super : false
  end
end
