class Category < ActiveRecord::Base
  has_and_belongs_to_many :projects, -> { uniq }

  # Validations
  validates_presence_of :name

  default_scope { order(:position) }
end
