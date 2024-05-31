class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_books, through: :likes, source: :book
  has_many :book_comments, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :post_liked_posts, through: :post_likes, source: :post
  has_many :post_comments, dependent: :destroy

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  def already_liked?(book)
    self.likes.exists?(book_id: book.id)
  end

  def already_post_liked?(post)
    self.post_likes.exists?(post_id: post.id)
  end

end
