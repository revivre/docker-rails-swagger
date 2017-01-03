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

  context 'PUT' do
    before do
      @user = FactoryGirl.create(:user)
      @path = "/v1/users/#{@user.id}.json"
    end

    it 'updates a user with all attributes' do
      @params = { params: FactoryGirl.attributes_for(:user,
                    name: 'Edgar', email: 'edgar@example.com', age: 45) }
      put @path, @params
      expect(response).to be_success
      expect(response).to have_http_status(:success)

      expect(@user.reload.name).to eq 'Edgar'
      expect(@user.reload.email).to eq 'edgar@example.com'
      expect(@user.reload.age).to eq 45
    end

    it 'updates a user with an attribute' do
      @params = { params: FactoryGirl.attributes_for(:user,
                    name: 'Fridge')}
      put @path, @params
      expect(response).to be_success
      expect(response).to have_http_status(:success)

      expect(@user.reload.name).to eq 'Fridge'
      expect(@user.reload.email).not_to eq 'fridge@example.com'
    end
  end
end
