require 'rails_helper'

RSpec.describe 'Categories Page', type: :feature do
  let!(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password', confirmed_at: Time.now) }

  before do
    @category1 = Category.create(user:, name: 'food', icon: 'https://cdn.jpegmini.com/user/images/slider_puffin_before_mobile.jpg')
    @category2 = Category.create(user:, name: 'travel', icon: 'https://cdn.jpegmini.com/user/images/slider_puffin_before_mobile.jpg')

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit categories_path
  end

  it 'displays list of category names and total sum of transactions' do
    expect(page).to have_content('CATEGORIES')
    expect(page).to have_content('Food')
    expect(page).to have_content('Travel')

    expect(page).to have_content('$0.0')
  end

  it 'displays category icons' do
    expect(page).to have_css("img[src='https://cdn.jpegmini.com/user/images/slider_puffin_before_mobile.jpg']")
  end

  it 'contains links to view category transactions and add a new category' do
    expect(page).to have_link('Food', href: category_transaction_entries_path(@category1))
    expect(page).to have_link('Travel', href: category_transaction_entries_path(@category2))

    expect(page).to have_link('Add a New Category', href: new_category_path)
  end

  it 'navigates to the category transactions page when a category link is clicked' do
    click_link('Food')
    expect(page).to have_current_path(category_transaction_entries_path(@category1))
  end

  it 'navigates to the new category page when "Add a New Category" link is clicked' do
    click_link('Add a New Category')
    expect(page).to have_current_path(new_category_path)
  end
end
