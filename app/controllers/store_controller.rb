class StoreController < ApplicationController
  before_action :session_counter, only: [:index]

  def index
  	@products = Product.order(:title)
  end

  private

  def session_counter
  	if session[:counter].nil?
  		session[:counter] = 1
  	else
  		session[:counter] += 1
  	end
  end
end
