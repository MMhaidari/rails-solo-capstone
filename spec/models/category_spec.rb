require 'rails_helper'

RSpec.describe 'Category', type: :model do
  let!(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }

  before do
    @category = Category.create(user: user, name: 'test', icon: 'https://cdn.jpegmini.com/user/images/slider_puffin_before_mobile.jpg')
  end

  it 'is valid with valid attributes' do
    expect(@category).to be_valid
  end

  it 'is not valid without a name' do
    @category.name = nil
    expect(@category).not_to be_valid
  end

  it 'is not valid without a user' do
    @category.user = nil
    expect(@category).not_to be_valid
  end

  it 'is valid with a duplicate name for a different user' do
    another_user = User.create(name: 'another_test', email: 'another_test@test.com', password: 'password')
    duplicate_category = @category.dup
    duplicate_category.user = another_user
    expect(duplicate_category).to be_valid
  end

  it 'sets up associations correctly' do
    expect(Category.reflect_on_association(:user).macro).to eq(:belongs_to)
    expect(Category.reflect_on_association(:transaction_categories).macro).to eq(:has_many)
    expect(Category.reflect_on_association(:transaction_entries).macro).to eq(:has_many)
    expect(Category.reflect_on_association(:transaction_entries).options[:through]).to eq(:transaction_categories)
  end
end
