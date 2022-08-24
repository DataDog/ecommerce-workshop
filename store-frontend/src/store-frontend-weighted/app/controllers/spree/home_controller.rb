require 'ldclient-rb'

module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def show_message(s)
      puts "*** #{s}"
      puts
    end

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      @discounts = helpers.get_discounts.sample
      
      
      user = {
        key: "example-user-key",
        name: "Bob Loblaw"
      }

      if Rails.configuration.client.initialized?
        show_message "SDK successfully initialized!"
      else
        show_message "SDK failed to initialize"
        exit 1
      end

      # Put this under a feature flag
      flag_value = Rails.configuration.client.variation("configure-ad-weight", user, 0.0)
      ad_value = flag_value.to_f / 10

      if flag_value.to_f != 0.0
        @ads = helpers.get_ads_weighted(ad_value)
      else
        @ads = helpers.get_ads.sample
      end

      @ads['base64'] = Base64.encode64(open("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/banners/#{@ads['path']}").read).gsub("\n", '')
    end
  end
end
