Spree::Sample.load_sample('products')

size = Spree::OptionType.find_by!(presentation: 'Size')
color = Spree::OptionType.find_by!(presentation: 'Color')

ror_baseball_jersey = Spree::Product.find_by!(name: 'Datadog Baseball Jersey')
ror_baseball_jersey.option_types = [size, color]
ror_baseball_jersey.save!

spree_baseball_jersey = Spree::Product.find_by!(name: 'Spree Baseball Jersey')
spree_baseball_jersey.option_types = [size, color]
spree_baseball_jersey.save!
