class Project < ActiveRecord::Base
  belongs_to :category
  belongs_to :article
  has_many :project_images, dependent: :destroy
  accepts_nested_attributes_for :project_images, allow_destroy: true
end
