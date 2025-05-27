Rails.application.routes.draw do
  # get "up" => "rails/health#show", as: :rails_health_check
  devise_for :proponents
   root to: redirect("/api/v1/proponents")

   namespace :api do
    namespace :v1 do
      get "reports/salary_ranges", to: "reports#salary_ranges", as: :salary_ranges
      resources :proponents, only: [ :index, :new, :create, :edit, :update, :show ] do
        collection do
          post :calculate_inss
        end
      end
    end
  end
end
