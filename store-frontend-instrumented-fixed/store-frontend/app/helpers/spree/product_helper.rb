module Spree
    module ProductHelper
        def get_ads
            @ads = JSON.parse(Net::HTTP.get_response(URI('http://advertisements:5002/ads')).body)
          end
    end

end