class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  validates :title, presence: true, uniqueness: true

end
