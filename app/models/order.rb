class Order < ApplicationRecord

    before_validation  :generate_ordernumber
    before_save :verify_user_active_order, :set_total

    validates :orderNumber, :date, :total, presence: true

    validates :active, inclusion: [true, false]
    validates :active, exclusion: [nil]

    belongs_to :user
    has_many :order_items, autosave: true
    has_many :products, through: :order_items

    
    def deactivate
        self.update(active: false)
    end

    private
    def verify_user_active_order
        if self.user.has_active_order
            throw :abort
        end
    end

    def generate_ordernumber
        self.orderNumber= SecureRandom.random_number(100000000);
    end

    def set_total
        self.order_items.each { |element|
            element.set_total()
            self.total += element.total;
        }
    end

end
