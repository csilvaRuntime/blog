class Tag < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates_uniqueness_of :name
    has_many :article_tags
    has_many :articles, through: :article_tags
end