class DiscountsController < ApplicationController
  def get
    @discounts = Net::HTTP.get_response(URI('http://discounts:5001/discount')).body
    logger.info @discounts
    render json: @discounts
  end

  def add
  end
end
