class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be a valid email address' }, uniqueness: true
    validates :password, presence: true
    encrypts :password
    enum :user_role, { normal: 0, admin: 1}
    validates :user_role, presence: true
    enum :state, { inactive: 0, active: 1}
    validates :state, presence: true
    has_many :articles

    scope :is_active, -> { where(state: 1) }

    def authenticate(email,password)
      user = User.find_by(email: email)
      user.password == password
	  end

end