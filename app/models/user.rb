class User < ApplicationRecord
    validates :name, :lastName, :birthDate, :password, :active, :email, presence: true
    validates :password , length: { minimum: 3 }

    validates :email,   format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email invalid"  },
                        uniqueness: { case_sensitive: false },
                        length: { minimum: 4, maximum: 254 }

end
