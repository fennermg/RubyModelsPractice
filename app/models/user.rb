require 'bcrypt'

class User < ApplicationRecord

    include ActiveModel::SecurePassword


    validates :name, :lastName, :birthDate, :password_digest, :email, presence: true
    
    validates :password_digest , length: { minimum: 3 }

    validates :active, inclusion: [true, false]
    validates :active, exclusion: [nil]

    validate :valid_date

    validates :email,   format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email invalid"  },
                        uniqueness: { case_sensitive: false },
                        length: { minimum: 4, maximum: 254 }



    def deactivate
        self.update(active: false)
    end

    def get_age
        now = Time.current
        born = self.birthDate
        now.year - born.year - ((now.month>born.month||(now.month==born.month && now.day >=born.day))? 0 : 1)
    end

    def has_active_order
        orders = self.orders
        active = orders.select{|element| element.active == true}
        active.length > 1
    end

    def self.get_active_users
        self.where("active = true")
    end

    def valid_date
        if self.get_age < 13
            errors.add(:birthDate, "invalid date")
        end
    end

    has_many :orders
    has_many :order_items, through: :orders

    has_secure_password
end
