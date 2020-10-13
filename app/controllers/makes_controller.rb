# frozen_string_literal: true

class MakesController < ApplicationController
  def index
    @makes = Make.all
    @count = Make.count
    @models = Make.model_name
  end

  def show
    @make = Make.includes(:models).find(params[:id])
    @model = Model.all
  end
end
