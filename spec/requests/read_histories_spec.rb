require 'rails_helper'

RSpec.describe "ReadHistories", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/read_histories/new"
      expect(response).to have_http_status(:success)
    end
  end

end
