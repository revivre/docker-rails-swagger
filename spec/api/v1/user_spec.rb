require 'rails_helper'

describe '/v1/users' do
  context 'GET' do
    before do
      @user1 = FactoryGirl.create(:user, { name: 'Alice' })
      @user2 = FactoryGirl.create(:user, { name: 'Bob' })
      get "/v1/users.json"
      @json = JSON.parse(response.body)
    end

    it 'returns users list' do
      expect(response).to be_success
      expect(response).to have_http_status(:success)

      expect(@json[0]['name']).to eq 'Alice'
      expect(@json[1]['name']).to eq 'Bob'
    end
  end
end

describe '/v1/users/:id' do
  context 'GET' do
    before do
      @user = FactoryGirl.create(:user, { name: 'Charlie' })
      get "/v1/users/#{@user.id}.json"
      @json = JSON.parse(response.body)
    end

    it 'returns Charlie\'s name ' do
      expect(response).to be_success
      expect(response).to have_http_status(:success)

      expect(@json['name']).to eq 'Charlie'
    end
  end
end
