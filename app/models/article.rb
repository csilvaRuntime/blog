class Article < ApplicationRecord
    validates :title, presence: true, if: -> {self.state.in? ARTICLE_SUBMITTED}, length: {maximum: 40}
    validates :text, presence: true, if: -> {self.state.in? ARTICLE_SUBMITTED}
    validate :valid_articles_states

    ARTICLE_STATES = %w(submitted pending draft)
    ARTICLE_SUBMITTED = %w(submitted)

    scope :is_submitted, -> { where(state: 'submitted') }

    private

    def valid_articles_states
        return if self.state.in? ARTICLE_STATES
        self.errors.add()
    end
end
