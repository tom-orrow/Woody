class Category < ActiveRecord::Base
  has_many :projects

  # Validations
  validates_presence_of :name

  default_scope { order(:position) }
end
