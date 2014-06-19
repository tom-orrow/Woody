class Project < ActiveRecord::Base
  belongs_to :category
  has_many :project_images, dependent: :destroy
  accepts_nested_attributes_for :project_images, allow_destroy: true
end
