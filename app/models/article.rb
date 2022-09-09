class Article < ApplicationRecord
    validates :title, presence: true, if: -> {submitted?}, length: {maximum: 40} #TODO:
    validates :text, presence: true, if: -> {submitted?} #TODO: comparar com array
    validates_uniqueness_of :title
    validate :valid_articles_states
    belongs_to :user
    has_many :article_tags
    has_many :tags, through: :article_tags
    accepts_nested_attributes_for :article_tags
    
    after_validation :set_slug, only: [:create, :update]
    before_save :register_date_submitted

    ARTICLE_STATES = %w(submitted pending draft)

    scope :is_submitted, -> { where(state: 'submitted') }
    scope :is_pending, -> { where(state: 'pending') }
    scope :is_draft, -> { where(state: 'draft') }

    def submitted?
        self.state == "submitted"
    end

    def to_param
        slug
    end

    private

    def valid_articles_states
        return if self.state.in? ARTICLE_STATES
        self.errors.add :state, "is not valid" #TODO
    end

    def set_slug
        self.slug = title.parameterize
    end 

    def register_date_submitted
        self.date_submitted = DateTime.now if (id.nil? && submitted?) || (self.state_changed? && submitted?)
    end
end
