require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'ensures order number is created' do
    user = User.new(name: "Fenner", lastName:"Mena", birthDate: "1996/04/16", password: "secret", email: "email@mail.com").save
    user=User.first
    user.orders.new(date: Time.now).save
    expect(user.orders[0].orderNumber).to be_a_kind_of(Integer)
  end

  it 'ensures user can not create an order if another is active' do
    user = User.new(name: "Fenner", lastName:"Mena", birthDate: "1996/04/16", password: "secret", email: "email@mail.com").save
    user=User.first
    user.orders.new(date: Time.now).save
    expect(user.orders.new(date: Time.now).save).to eq(false)
  end

  it 'ensures order can be deactivated' do
    user = User.new(name: "Fenner", lastName:"Mena", birthDate: "1996/04/16", password: "secret", email: "email@mail.com").save
    user=User.first
    user.orders.new(date: Time.now).save
    user.orders[0].deactivate
    expect(user.orders[0].active).to eq(false)
  end

  it 'ensures user can not add duplicated order_items'do
    user = User.new(name: "Fenner", lastName:"Mena", birthDate: "1996/04/16", password: "secret", email: "email@mail.com").save
    user=User.first
    user.orders.new(date: Time.now).save
    product = Product.new(name: "Producto1", price: 50, quantity: 5).save
    product=Product.first
    user.orders.first.order_items.new(quantity: 5, product_id: product.id)
    user.orders.first.order_items.new(quantity: 5, product_id: product.id)

    expect(user.orders.first.save).to eq(false)
  end
end
