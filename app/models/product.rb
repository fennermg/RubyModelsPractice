class Product < ApplicationRecord

    before_validation :generate_productcode

    validates :name, :code, :price, :quantity, presence: true

    validates :active, inclusion: [true, false]

    validates :price, numericality: { greater_than: 0.0 }


    def generate_productcode
        self.code= SecureRandom.random_number(100000000);
    end

    def deactivate
        self.update(active: false)
    end

    has_many :order_items
end
