# Possibly already created by a migration.
unless Spree::Store.where(code: 'spree').exists?
  Spree::Store.new do |s|
    s.code              = 'spree'
    s.name              = 'storedog'
    s.url               = 'example.com'
    s.mail_from_address = 'spree@example.com'
    s.default_currency  = 'USD'
  end.save!
end
