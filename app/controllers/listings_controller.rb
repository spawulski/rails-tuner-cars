# frozen_string_literal: true

class ListingsController < ApplicationController
  # http_basic_authenticate_with name: 'ghostface', password: 'killa'
  def index
    @listings = Listing.order(:province).page(params[:page])
    @count = Listing.count
    @models = Model.all
    @makes = Make.all
    @provinces = Province.all

    @search = params['search']
    if @search.present?
      @title = @search['title']
      @listings = Listing.where('title like ?', "%#{@title}%").page(params[:page])
      puts @listings
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end
end
