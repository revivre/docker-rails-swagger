require 'rails_helper'
  describe '/v1/users' do
    context 'GET' do
      it 'get all users' do
        get '/v1/users'

        expect(response).to have_http_status(:success)
      end
    end
  end
