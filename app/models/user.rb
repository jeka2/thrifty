class User < ApplicationRecord
    has_secure_password

    has_many :items, foreign_key: 'creator_id'
    has_many :comments

    validates :email, 
    format: { with: /\A(.+)@(.+)\z/, message: "invalid" },
              presence: true, uniqueness: true,
              length: { minimum: 5, maximum: 100 }

    validates :password, 
    format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\z/,
              message: "must be at least 8 characters long, contain at least one uppercase letter, one lowecase letter, one number and one special character" },
              presence: true, confirmation: true

end
