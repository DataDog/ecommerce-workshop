module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      @discounts = helpers.get_discounts.sample
      @ads = helpers.get_ads.sample
      @ads['base64'] = Base64.encode64(open("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/banners/#{@ads['path']}").read).gsub("\n", '')
    end
  end
end
