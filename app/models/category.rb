class Category < ActiveRecord::Base
  has_many :projects

  # Validations
  validates_presence_of :name

end
