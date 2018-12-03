class Country < ApplicationRecord
  # validation
  validates_presence_of :name, :code
end
