# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

FriendlyId::Slug.create!([
  {slug: "datadog-tote", sluggable_id: 1, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "datadog-bag", sluggable_id: 2, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "datadog-baseball-jersey", sluggable_id: 3, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "datadog-jr-spaghetti", sluggable_id: 4, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "datadog-ringer-t-shirt", sluggable_id: 5, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "apache-baseball-jersey", sluggable_id: 6, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "spree-baseball-jersey", sluggable_id: 7, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "spree-jr-spaghetti", sluggable_id: 8, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "spree-ringer-t-shirt", sluggable_id: 9, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "spree-tote", sluggable_id: 10, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "spree-bag", sluggable_id: 11, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "datadog-mug", sluggable_id: 12, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "datadog-stein", sluggable_id: 13, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "monitoring-stein", sluggable_id: 14, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "monitoring-mug", sluggable_id: 15, sluggable_type: "Spree::Product", scope: nil, deleted_at: nil},
  {slug: "categories", sluggable_id: 1, sluggable_type: "Spree::Taxon", scope: nil, deleted_at: nil},
  {slug: "brands", sluggable_id: 2, sluggable_type: "Spree::Taxon", scope: nil, deleted_at: nil},
  {slug: "bags", sluggable_id: 3, sluggable_type: "Spree::Taxon", scope: nil, deleted_at: nil},
  {slug: "mugs", sluggable_id: 4, sluggable_type: "Spree::Taxon", scope: nil, deleted_at: nil},
  {slug: "clothing", sluggable_id: 5, sluggable_type: "Spree::Taxon", scope: nil, deleted_at: nil},
  {slug: "shirts", sluggable_id: 6, sluggable_type: "Spree::Taxon", scope: nil, deleted_at: nil},
  {slug: "t-shirts", sluggable_id: 7, sluggable_type: "Spree::Taxon", scope: nil, deleted_at: nil}
])
Spree::Calculator.create!([
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 1, preferences: {:amount=>5, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 2, preferences: {:amount=>10, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 3, preferences: {:amount=>15, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 4, preferences: {:amount=>5, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 5, preferences: {:amount=>8, :currency=>"EUR"}, deleted_at: nil},
  {type: "Spree::Calculator::DefaultTax", calculable_type: "Spree::TaxRate", calculable_id: 1, preferences: {}, deleted_at: nil}
])
Spree::PaymentMethod.create!([
  {type: "Spree::PaymentMethod::StoreCredit", name: "Store Credit", description: "Store Credit", active: true, deleted_at: nil, display_on: "back_end", auto_capture: nil, preferences: {}, position: 1},
  {type: "Spree::Gateway::Bogus", name: "Credit Card", description: "Bogus payment gateway.", active: true, deleted_at: nil, display_on: "both", auto_capture: nil, preferences: {:server=>"test", :test_mode=>true}, position: 2},
  {type: "Spree::PaymentMethod::Check", name: "Check", description: "Pay by check.", active: true, deleted_at: nil, display_on: "both", auto_capture: nil, preferences: {}, position: 3}
])
Spree::Order.create!([
  {number: "R246115036", item_total: "54.97", total: "54.97", state: "cart", adjustment_total: "0.0", user_id: nil, completed_at: nil, bill_address_id: nil, ship_address_id: nil, payment_total: "0.0", shipment_state: nil, payment_state: nil, email: nil, special_instructions: nil, currency: "USD", last_ip_address: nil, created_by_id: nil, shipment_total: "0.0", additional_tax_total: "0.0", promo_total: "0.0", channel: "spree", included_tax_total: "0.0", item_count: 3, approver_id: nil, approved_at: nil, confirmation_delivered: false, considered_risky: false, token: "aeihRQ1NnX7TbfvhhtQNNg1567611578919", canceled_at: nil, canceler_id: nil, store_id: 1, state_lock_version: 0, taxable_adjustment_total: "0.0", non_taxable_adjustment_total: "0.0"}
])
Spree::User.create!([
  {encrypted_password: "501aea7cbee2b629ba36ea1281814bc40a78670aed2ebdffc470e1e851261923e86829a04d84d3603641141cfd8d8a46fba73b32ecbee5611caaab43e3d5cdbb", password_salt: "PFVRzux6qoy93HyMezrU", email: "spree@example.com", remember_token: nil, persistence_token: nil, reset_password_token: nil, perishable_token: nil, sign_in_count: 0, failed_attempts: 0, last_request_at: nil, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, login: "spree@example.com", ship_address_id: nil, bill_address_id: nil, authentication_token: nil, unlock_token: nil, locked_at: nil, reset_password_sent_at: nil, spree_api_key: "5b94d0f875a12339eafcac675691f10f50ad0f44c9ea9743", remember_created_at: nil, deleted_at: nil, confirmation_token: nil, confirmed_at: nil, confirmation_sent_at: nil}
])
Spree::Preference.create!([
  {value: 233, key: "spree/app_configuration/default_country_id"},
  {value: "USD", key: "spree/app_configuration/currency"}
])
Spree::Role.create!([
  {name: "admin"},
  {name: "user"}
])
Spree::ShippingCalculator.create!([
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 1, preferences: {:amount=>5, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 2, preferences: {:amount=>10, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 3, preferences: {:amount=>15, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 4, preferences: {:amount=>5, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 5, preferences: {:amount=>8, :currency=>"EUR"}, deleted_at: nil}
])
Spree::Calculator::DefaultTax.create!([
  {type: "Spree::Calculator::DefaultTax", calculable_type: "Spree::TaxRate", calculable_id: 1, preferences: {}, deleted_at: nil}
])
Spree::Calculator::Shipping::FlatRate.create!([
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 1, preferences: {:amount=>5, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 2, preferences: {:amount=>10, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 3, preferences: {:amount=>15, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 4, preferences: {:amount=>5, :currency=>"USD"}, deleted_at: nil},
  {type: "Spree::Calculator::Shipping::FlatRate", calculable_type: "Spree::ShippingMethod", calculable_id: 5, preferences: {:amount=>8, :currency=>"EUR"}, deleted_at: nil}
])
Spree::Gateway.create!([
  {type: "Spree::Gateway::Bogus", name: "Credit Card", description: "Bogus payment gateway.", active: true, deleted_at: nil, display_on: "both", auto_capture: nil, preferences: {:server=>"test", :test_mode=>true}, position: 2}
])
Spree::PaymentMethod::Check.create!([
  {type: "Spree::PaymentMethod::Check", name: "Check", description: "Pay by check.", active: true, deleted_at: nil, display_on: "both", auto_capture: nil, preferences: {}, position: 3}
])
Spree::PaymentMethod::StoreCredit.create!([
  {type: "Spree::PaymentMethod::StoreCredit", name: "Store Credit", description: "Store Credit", active: true, deleted_at: nil, display_on: "back_end", auto_capture: nil, preferences: {}, position: 1}
])
Spree::Gateway::Bogus.create!([
  {type: "Spree::Gateway::Bogus", name: "Credit Card", description: "Bogus payment gateway.", active: true, deleted_at: nil, display_on: "both", auto_capture: nil, preferences: {:server=>"test", :test_mode=>true}, position: 2}
])
