module ApplicationHelper
    def get_ads
        @ads = JSON.parse(Net::HTTP.get_response(URI('http://advertisements:' + ENV['ADS_PORT'] + '/ads')).body)
      end
  
end
