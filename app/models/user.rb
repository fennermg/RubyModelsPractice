class User < ApplicationRecord
    validates :name, :lastName, :birthDate, :password, :email, presence: true
    
    validates :password , length: { minimum: 3 }

    validates :active, inclusion: [true, false]
    validates :active, exclusion: [nil]

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

    def self.get_active_users
        self.where("active = true")
    end

end
