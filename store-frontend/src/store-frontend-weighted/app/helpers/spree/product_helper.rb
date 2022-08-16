module Spree
    module ProductHelper
        def get_ads
            @ads = JSON.parse(Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/ads")).body)
          end
    end

end