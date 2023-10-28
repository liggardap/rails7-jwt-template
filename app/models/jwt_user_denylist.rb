# frozen_string_literal: true

class JwtUserDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist
end
