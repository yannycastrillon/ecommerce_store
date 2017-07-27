class User < ApplicationRecord
  # ActiveRecord method enum, maps each symbol to an index in the db.
  enum role: [:customer, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
    self.role ||= :customer
  end
end
