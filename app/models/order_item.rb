class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :product

    before_save :avoid_duplicate_product_on_order


    private
    def avoid_duplicate_product_on_order
        list = self.order.order_items

        duplicated = list.select{|element| element.order_id == self.order.id && element.product_id == self.product_id}

        if duplicated.length > 0
            duplicated[0].increment!(:quantity)
            duplicated[0].mark_for_destruction
        end
    end


end
