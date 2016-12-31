module Entities
  module V1
    class UserEntity < RootEntity
      expose :name
      expose :email
      expose :age
    end
  end
end
