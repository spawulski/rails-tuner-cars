# frozen_string_literal: true

class Model < ApplicationRecord
  belongs_to :make
  has_many :listings
end
