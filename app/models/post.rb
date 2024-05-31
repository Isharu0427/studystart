class Post < ApplicationRecord
    belongs_to :user
    mount_uploader :image, ImageUploader
    has_many :post_likes, dependent: :destroy
    has_many :post_liked_users, through: :post_likes, source: :user
    has_many :post_comments, dependent: :destroy
end