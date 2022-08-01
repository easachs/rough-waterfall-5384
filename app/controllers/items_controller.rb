class ItemsController < ApplicationController

  def index
    @supermarket = Supermarket.find(params[:supermarket_id])
  end

end