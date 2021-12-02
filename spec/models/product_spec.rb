require 'rails_helper'

RSpec.describe Product, type: :model do

  it 'ensures product name is present' do
    product = Product.new(price: 50, quantity: 5).save
    expect(product).to eq(false)
  end

  it 'ensures product price is present' do
    product = Product.new(name: "Producto1", quantity: 5).save
    expect(product).to eq(false)
  end

  it 'ensures product price is higher that 0.0' do
    product = Product.new(name: "Producto1", price: 0, quantity: 5).save
    expect(product).to eq(false)
  end

  it 'ensures product quantity is present' do
    product = Product.new(name: "Producto1", price: 50).save
    expect(product).to eq(false)
  end

  it 'ensures code is created' do
    product = Product.new(name: "Producto1", price: 50, quantity: 5).save
    product= Product.first
    expect(product.code).to be_a_kind_of(Integer)
  end

  it 'ensures product can be deactivated' do
    product = Product.new(name: "Producto1", price: 50, quantity: 5).save
    product= Product.first
    product.deactivate
    expect(product.active).to eq(false)
  end
end
