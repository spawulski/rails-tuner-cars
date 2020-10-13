# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :make
  belongs_to :model
  belongs_to :province
  paginates_per 10

  validates :make, :model, :province, :url, presence: true
end
