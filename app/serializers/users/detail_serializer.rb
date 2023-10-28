# frozen_string_literal: true

class Users::DetailSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone, :username, :type, :created_at
end
