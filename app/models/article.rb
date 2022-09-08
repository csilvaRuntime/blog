class Article < ApplicationRecord
    validates :title, presence: true, if: -> {submitted?}, length: {maximum: 40} #TODO:
    validates :text, presence: true, if: -> {submitted?} #TODO: comparar com array
    validate :valid_articles_states
    belongs_to :user

    ARTICLE_STATES = %w(submitted pending draft)

    scope :is_submitted, -> { where(state: 'submitted') }
    scope :is_pending, -> { where(state: 'pending') }
    scope :is_draft, -> { where(state: 'draft') }


    def submitted?
        self.state == "submitted"
    end

    private

    def valid_articles_states
        return if self.state.in? ARTICLE_STATES
        self.errors.add :state, "is not valid" #TODO
    end
end
