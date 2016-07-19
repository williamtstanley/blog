class User < ActiveRecord::Base

    has_many :favorites, dependent: :destroy
    has_many :favorited_posts, through: :favorites, source: :post


    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :destroy

    has_secure_password

    validates :first_name, presence: true
    validates :last_name, presence: true

    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, format: VALID_EMAIL_REGEX, uniqueness: true

    def full_name
        "#{first_name.capitalize} #{last_name.capitalize}"
    end
end
