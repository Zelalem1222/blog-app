class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id

  validates :title, presence: true, allow_blank: false, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 } , allow_nil: true 
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 } , allow_nil: true 
  def most_recent_likes
    likes.order(created_at: :desc).limit(5)
  end

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end


