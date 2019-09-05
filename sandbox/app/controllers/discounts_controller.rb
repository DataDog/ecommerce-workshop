class DiscountsController < ApplicationController
  def get
    reponse = Net::HTTP.get_response(URI('http://discounts:5001/discount'))

    logger.info response.body
  end

  def add
  end
end
