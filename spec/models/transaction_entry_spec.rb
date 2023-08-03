require 'rails_helper'

RSpec.describe 'TransactionEntry', type: :model do
  let!(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }

  before do
    @transaction_entry = TransactionEntry.create(user:, name: 'test', amount: 200)
  end

  it 'is valid with valid attributes' do
    expect(@transaction_entry).to be_valid
  end

  it 'is not valid without a name' do
    @transaction_entry.name = nil
    expect(@transaction_entry).not_to be_valid
  end

  it 'is not valid without an amount' do
    @transaction_entry.amount = nil
    expect(@transaction_entry).not_to be_valid
  end

  it 'is not valid without a user' do
    @transaction_entry.user = nil
    expect(@transaction_entry).not_to be_valid
  end

  it 'has correct associations' do
    expect(TransactionEntry.reflect_on_association(:user).macro).to eq(:belongs_to)
  end
end
