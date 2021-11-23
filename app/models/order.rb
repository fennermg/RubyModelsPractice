class Order < ApplicationRecord

    validates :orderNumber, :date, :total, presence: true

    validates :active, inclusion: [true, false]
    validates :active, exclusion: [nil]

    belongs_to :user
    has_many :order_items
    has_many :products, through: :order_items

end
