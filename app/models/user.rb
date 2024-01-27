# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
        #  :confirmable,
         jwt_revocation_strategy: JwtUserDenylist

  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates_presence_of :type

  validates :email, uniqueness: { scope: :type }

  def role_type
    type.split('::').last.downcase
  end
end
