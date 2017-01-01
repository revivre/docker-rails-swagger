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

  context 'POST' do
    let(:path) { '/v1/users.json' }
    before do
      @params = { params: FactoryGirl.attributes_for(:user,
                    name: 'Dylan', email: 'dylan@example.com', age: 39) }
    end

    it 'creates a user' do
      post path, @params
      @json = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status(:created)

      expect(@json['name']).to eq 'Dylan'
      expect(@json['email']).to eq 'dylan@example.com'
      expect(@json['age']).to eq 39
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
