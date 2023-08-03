require 'rails_helper'

RSpec.describe 'Category Transactions', type: :feature do
  let!(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }
  let!(:category) { Category.create(name: 'Test Category', icon: 'https://example.com/icon.png', user:) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    category.transaction_entries.create(name: 'Transaction 1', amount: 50)
    category.transaction_entries.create(name: 'Transaction 2', amount: 75)

    visit category_transaction_entries_path(category)
  end

  it 'navigates to the "Add a New Transaction" page when the link is clicked' do
    click_link('Add a New Transaction')
    expect(page).to have_current_path(new_category_transaction_entry_path(category))
  end

  it 'navigates back to the categories page when "Back" link is clicked' do
    click_link('Back')
    expect(page).to have_current_path(categories_path)
  end

  it 'redirects to correct page when clicked' do
    click_link('Back')
    expect(page).to have_current_path(categories_path)
  end
end
