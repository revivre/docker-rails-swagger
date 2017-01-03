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
        desc 'update user'
        params do
          requires :id, type: String, desc: 'user id'
          requires :name, type: String, desc: 'user name'
          requires :email, type: String, desc: 'user email'
          requires :age, type: String, desc: 'user age'
        end
        put ':id' do
          @user = User.find(params[:id])
          @user.name = params[:name] if params[:name]
          @user.email = params[:email] if params[:email]
          @user.age = params[:age] if params[:age]
          @user.save

          present User.find(params[:id]), with: Entities::V1::UserEntity
        end
      end
    end
  end
end
