class DiscountsController < ApplicationController
  def get
    response = HTTParty.get('https://www.google.com')
    logger.info response.body
  end

  def add
  end
end
