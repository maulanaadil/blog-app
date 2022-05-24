class Article < ApplicationRecord
    belongs_to :user
    belongs_to :category

    validates :title, presence: true, length: { minimum: 5, maximum: 255 }
    validates :content, presence: true, length: { minimum: 20, maximum: 1000 }
    validates :category_id, presence: true

    self.per_page = 10
    WillPaginate.per_page = 10
end
