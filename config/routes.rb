# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: 'api/v1/users',
             path_names: { sign_in: :login, sign_out: :logout, sign_up: :register },
             controllers: { sessions: 'users/sessions',
                            registrations: 'users/registrations' }
end
