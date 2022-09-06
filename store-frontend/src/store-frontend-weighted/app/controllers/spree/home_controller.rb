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

      # Put this under a feature flag
      flag = helpers.get_ld_config("configure-ad-weight", 0.0)
      ad_value = flag.to_f / 10

      if flag.to_f != 0.0
        @ads = helpers.get_ads_weighted(ad_value)
      else
        @ads = helpers.get_ads.sample
      end

      @ads['base64'] = Base64.encode64(open("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/banners/#{@ads['path']}").read).gsub("\n", '')
    end
  end
end
