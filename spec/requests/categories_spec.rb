require 'rails_helper'

RSpec.describe 'CategoriesController', type: :request do
  let!(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }
  def sign_in_user
    post user_session_path, params: { user: { email: user.email, password: 'password' } }
  end

  describe 'GET /categories' do
    it 'responds with success' do
      sign_in_user
      get '/categories'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(assigns(:categories)).to eq(user.categories.includes(:transaction_entries))
    end
  end

  describe 'GET /categories/new' do
    it 'responds with success' do
      sign_in_user
      get '/categories/new'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'POST /categories' do
    context 'with valid parameters' do
      it 'creates a new category and redirects to categories_path' do
        sign_in_user
        valid_params = { category: { name: 'Foods', icon: 'https://example.com' } }
        post '/categories', params: valid_params
        expect(Category.count).to eq(1)
        expect(response).to redirect_to(categories_path)
        expect(flash[:notice]).to eq('Category created successfully!')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category and renders the new template' do
        sign_in_user
        invalid_params = { category: { icon: 'https://example.com' } }
        post '/categories', params: invalid_params
        expect(Category.count).to eq(0)
        expect(response).to render_template(:new)
        expect(flash[:error]).to eq('Category not created!')
      end
    end
  end
end
