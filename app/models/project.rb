class Project < ActiveRecord::Base
  # Associations
  belongs_to :category
  belongs_to :article
  has_many :project_images, dependent: :destroy
  accepts_nested_attributes_for :project_images, allow_destroy: true

  # Validations
  validates_presence_of :name
  validates_presence_of :desc

  default_scope { order(:position) }
end
