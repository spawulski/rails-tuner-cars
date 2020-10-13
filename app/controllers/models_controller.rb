# frozen_string_literal: true

class ModelsController < ApplicationController
  def index
    @makes = Make.all
    @count = Model.count
    @models = Model.all
  end

  def show
    # @make = Make.includes(:models).find(params[:id])
    @model = Model.includes(:make).find(params[:id])
    @listings = Listing.all
    @provinces = Province.all
    # @modellisting = Model.includes(:listing).find(params[:id])
  end
end
