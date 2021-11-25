class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :product

    before_save :increment_first_item
    after_commit :destroy_duplicates

    private
    def increment_first_item
        list = self.order.order_items
        
        duplicated = list.select{|element| element.order_id == self.order.id && element.product_id == self.product_id}

        if duplicated.length > 0
            if !duplicated[0].id.nil?
                duplicated[0].increment!(:quantity, self.quantity)
            end
        end
    end



    def destroy_duplicates

        list = OrderItem.all

        duplicated = list.select{|element| element.order_id == self.order.id && element.product_id == self.product_id}

        duplicated.each_with_index do |value, index|
            if index != 0
                duplicated[index].destroy
            end
        end

    end


end
