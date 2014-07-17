class Project < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :categories, -> { uniq.order("categories.id ASC") }
  belongs_to :article
  has_many :project_images, dependent: :destroy
  accepts_nested_attributes_for :project_images, allow_destroy: true

  # Validations
  validates_presence_of :name
  validates_presence_of :desc

  default_scope { order(:position) }
end
