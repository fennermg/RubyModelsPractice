require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ensures first name presence' do
    user = User.new(lastName: 'last', birthDate: "1996/04/16", password: "secret", email: "email@mail.com").save
    expect(user).to eq(false)
  end

  it 'ensures last name presence' do
    user = User.new(name: "Fenner", birthDate: "1996/04/16", password: "secret", email: "email@mail.com").save
    expect(user).to eq(false)
  end

  it 'ensures valid birth date' do
    user = User.new(name: "Fenner", lastName:"Mena", birthDate: Time.now, password: "secret", email: "email@mail.com").save
    expect(user).to eq(false)
  end

  it 'ensures valid email address' do
    user = User.new(name: "Fenner", lastName:"Mena", birthDate: "1996/04/16", password: "secret", email: "emailmail.com").save
    expect(user).to eq(false)
  end

  it 'ensures user can be deactivated' do
    user = User.new(name: "Fenner", lastName:"Mena", birthDate: "1996/04/16", password: "secret", email: "email@mail.com").save
    user= User.first
    user.deactivate
    expect(user.active).to eq(false)
  end

end
