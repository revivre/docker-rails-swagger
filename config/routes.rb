Rails.application.routes.draw do
  #get 'welcome/index'

  #root 'welcome#index'
  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/' if defined? GrapeSwaggerRails
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
