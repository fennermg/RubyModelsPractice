class Order < ApplicationRecord

    validates :orderNumber, :date, :total, presence: true

    validates :active, inclusion: [true, false]
    validates :active, exclusion: [nil]

    belongs_to :user
    has_many :order_items
    has_many :products, through: :order_items

    before_validation :verify_user_active_order

    private
    def verify_user_active_order
        if self.user.has_active_order
            throw :abort
        end
    end

end
