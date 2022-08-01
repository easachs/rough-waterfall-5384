class CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    # require 'pry'; binding.pry
  end

end