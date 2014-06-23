class Article < ActiveRecord::Base
  extend FriendlyId
  mount_uploader :image, ImageUploader

  friendly_id :title, use: :slugged

  def next
    article = Article.where("id > ?", id).order("id ASC").first
    if !article
      article = Article.first
    end
    article
  end

  def prev
    article = Article.where("id < ?", id).order("id DESC").first
    if !article
      article = Article.last
    end
    article
  end
end
