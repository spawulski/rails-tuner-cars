# frozen_string_literal: true

class Make < ApplicationRecord
  has_many :models
  has_many :listings
end
