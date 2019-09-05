class DiscountsController < ApplicationController
  def get
    response = HTTParty.get('http://discounts/discount')
    logger.info response.body
  end

  def add
  end
end
