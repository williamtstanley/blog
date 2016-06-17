class Post < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    belongs_to :category
    belongs_to :user

    validates :title, presence: true, uniqueness: true, length: {minimum: 7}
    validates :body, presence: true

    scope :most_recent, -> {order(created_at: :desc).limit(3)}
    #search
    scope :search, -> (term) {where("title ILIKE :term OR body ILIKE :term", {term: "%#{term}%"})}

    def self.paginate(page)
        order(created_at: :desc).limit(10).offset(10 * (page))
    end

    def body_snippet
        body.length > 100 ? body[0...100] + "..." : body
    end

    def new_first_comments
        comments.order(created_at: :desc)
    end

end
