class DiscountsController < ApplicationController
  def get
    response = HTTParty.get('http://discounts:5001/discount')
    logger.info response.body
  end

  def add
  end
end
