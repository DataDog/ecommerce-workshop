module ApplicationHelper
    def get_ads
        @ads = JSON.parse(Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/ads")).body)
      end
    
    def get_ads_weighted(weight)
        @ads = JSON.parse(Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/weighted-banners/#{weight}")).body)
      end
  
end
