Rails.application.routes.draw do
  devise_for :users
    root to: 'pages#home'
    get 'about', to: 'pages#about'
    resources :contacts, only: :create
    # 'new_contact' there because we would have to hunt down all of the new_contacts we wrote and replace them with contact-us
    get 'contact-us', to: 'contacts#new', as: 'new_contact' 
end
