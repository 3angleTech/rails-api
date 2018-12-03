class User < ApplicationRecord
  # validations
  validates_presence_of :username, :password, :email, :first_name, :last_name

  def full_name
    first_name + ' ' + last_name
  end
end
