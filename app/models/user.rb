class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attachment :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, {uniqueness: true, length: {in: 2..20}}
  validates :introduction, length: {maximum:50}

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  def follow(anouther_user)
    if  self != anouther_user
      relationships.create(followed_id: anouther_user.id)
    end
  end

  def unfollow(anouther_user)
    if self != anouther_user
      relationships.find_by(followed_id: anouther_user.id).destroy
    end
  end

  def following?(anouther_user)
    followings.include?(anouther_user)
  end
end
