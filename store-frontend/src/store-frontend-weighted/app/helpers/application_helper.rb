require 'uuidtools'

module ApplicationHelper
    def get_ads
        @ads = JSON.parse(Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/ads")).body)
      end
    
    def get_ads_weighted(weight)
        @ads = JSON.parse(Net::HTTP.get_response(URI("#{ENV['ADS_ROUTE']}:#{ENV['ADS_PORT']}/weighted-banners/#{weight}")).body)
      end
      
    def get_ld_config(key, default)
      # check flag of LD Dashboard
      if spree_current_user.nil?
        if ! session[:hash_key]
          session[:hash_key] = UUIDTools::UUID.random_create.to_s
        end
        hash_key = session[:hash_key] 
        groups_for_user = nil
      else
        hash_key = spree_current_user.email
        #group_id = spree_current_user.group_id
        
        #if group_id == nil
        groups_for_user = nil
        #else
        #  groups_for_user = Spree::Group.find(group_id).name 
        #end
      end
  
      flag = Rails.configuration.ld_client.variation(key, {:key => hash_key, :custom => {:groups => groups_for_user}, :anonymous => spree_current_user.nil?}, default)
    end
end
