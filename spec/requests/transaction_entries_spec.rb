require 'rails_helper'

RSpec.describe "TransactionEntries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/transaction_entries/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/transaction_entries/new"
      expect(response).to have_http_status(:success)
    end
  end

end
