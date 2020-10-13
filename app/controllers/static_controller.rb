# frozen_string_literal: true

class StaticController < ApplicationController
  def show
    render params[:page]
  end
end
