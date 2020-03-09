shared_context 'custom products' do
  before do
    taxonomy = FactoryBot.create(:taxonomy, name: 'Categories')
    root = taxonomy.root
    clothing_taxon = FactoryBot.create(:taxon, name: 'Clothing', parent_id: root.id)
    bags_taxon = FactoryBot.create(:taxon, name: 'Bags', parent_id: root.id)
    mugs_taxon = FactoryBot.create(:taxon, name: 'Mugs', parent_id: root.id)

    taxonomy = FactoryBot.create(:taxonomy, name: 'Brands')
    root = taxonomy.root
    apache_taxon = FactoryBot.create(:taxon, name: 'Apache', parent_id: root.id)
    rails_taxon = FactoryBot.create(:taxon, name: 'Ruby on Rails', parent_id: root.id)
    ruby_taxon = FactoryBot.create(:taxon, name: 'Ruby', parent_id: root.id)

    FactoryBot.create(:custom_product, name: 'Datadog Ringer T-Shirt', price: '19.99', taxons: [rails_taxon, clothing_taxon])
    FactoryBot.create(:custom_product, name: 'Datadog Mug', price: '15.99', taxons: [rails_taxon, mugs_taxon])
    FactoryBot.create(:custom_product, name: 'Datadog Tote', price: '15.99', taxons: [rails_taxon, bags_taxon])
    FactoryBot.create(:custom_product, name: 'Datadog Bag', price: '22.99', taxons: [rails_taxon, bags_taxon])
    FactoryBot.create(:custom_product, name: 'Datadog Baseball Jersey', price: '19.99', taxons: [rails_taxon, clothing_taxon])
    FactoryBot.create(:custom_product, name: 'Datadog Stein', price: '16.99', taxons: [rails_taxon, mugs_taxon])
    FactoryBot.create(:custom_product, name: 'Datadog Jr. Spaghetti', price: '19.99', taxons: [rails_taxon, clothing_taxon])
    FactoryBot.create(:custom_product, name: 'Datadog Baseball Jersey', price: '19.99', taxons: [ruby_taxon, clothing_taxon])
    FactoryBot.create(:custom_product, name: 'Apache Baseball Jersey', price: '19.99', taxons: [apache_taxon, clothing_taxon])
  end
end
