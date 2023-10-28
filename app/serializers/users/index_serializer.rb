# frozen_string_literal: true

class Users::IndexSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone, :username, :type, :created_at
end
