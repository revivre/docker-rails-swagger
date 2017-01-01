module Resources
  module V1
    class Users < Grape::API
      resource :users do
        # http://localhost:3000/v1/users
        desc 'user list'
        get do
          present User.all, with: Entities::V1::UserEntity
        end
        # http://localhost:3000/v1/users/{:id}
        desc 'user'
        # パラメータ設定
        params do
          # 必須項目
          requires :id, type: Integer, desc: 'user id'
        end
        get ':id' do
          present User.find(params[:id]), with: Entities::V1::UserEntity
        end
        desc 'create user'
        params do
          requires :name, type: String, desc: 'user name'
          requires :email, type: String, desc: 'user email'
          requires :age, type: Integer, desc: 'user age'
        end
        post do
          User.create!({
            name: params[:name],
            email: params[:email],
            age: params[:age]
          })
        end
      end
    end
  end
end
