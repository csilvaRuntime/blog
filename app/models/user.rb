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

    before_save :register_update_password 

    scope :other_active_users, -> (user_id) {where.not(id: user_id).where(state:"active")}

    def authenticate(email,password)
      user = User.find_by(email: email)
      user.password == password
	  end

    def needs_to_update_password?(id)
      user = User.find(id)
      user.p_updated_at + 30.seconds < DateTime.now
    end

    private

    def register_update_password
      if id.nil? || password_changed?
        self.p_updated_at = DateTime.now
        self.state = "active"
      end
    end

end
