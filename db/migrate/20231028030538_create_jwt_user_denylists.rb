# frozen_string_literal: true

class CreateJwtUserDenylists < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_user_denylists do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false
    end

    add_index :jwt_user_denylists, :jti
  end
end
