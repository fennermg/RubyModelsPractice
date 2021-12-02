class Order < ApplicationRecord

    before_validation  :generate_ordernumber
    before_save :set_total

    validate :verify_user_active_order, :avoid_duplicated_orderitems, :avoid_deactivated_products

    validates :orderNumber, :date, :total, presence: true

    validates :active, inclusion: [true, false]

    belongs_to :user
    has_many :order_items, autosave: true
    has_many :products, through: :order_items

    
    def deactivate
        self.update(active: false)
    end

    private
    def verify_user_active_order
        if self.user.has_active_order
            errors.add(:active, "User already has an active order")
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

    def avoid_duplicated_orderitems
        items =  self.order_items

        for item in items
            duplicates = items.select{|element| element.product_id == item.product_id}
            if duplicates.length >1
                errors.add(:order_items, "Can't have duplicated items")
            end
        end
    end

    def avoid_deactivated_products
        order_items = self.order_items

        for order_item in order_items
            if !order_item.product.active
                errors.add(:order_item, "Can't have an deactivated product")
            end
        end
    end

end
