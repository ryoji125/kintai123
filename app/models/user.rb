class User < ApplicationRecord
    has_many :attendances, dependent: :destroy
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: {maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 100},
                            format: { with: VALID_EMAIL_REGEX},
                            uniqueness: { case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 },allow_nil: true
    validates :department, length: { in: 3..50 }, allow_blank: true
    
    scope :get_by_name, ->(name) {
        where("name like ?", "%#{name}%")
    }
    validates :worked_on, presence: true
end
