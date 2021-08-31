# This migration comes from spree (originally 20140723214541)
class CopyProductSlugsToSlugHistory < ActiveRecord::Migration[4.2]
  def change

	# do what sql does best: copy all slugs into history table in a single query
	# rather than load potentially millions of products into memory
	Spree::Product.connection.execute <<-SQL
INSERT INTO #{FriendlyId::Slug.table_name} (slug, sluggable_id, sluggable_type, created_at)
  SELECT slug, id, '#{Spree::Product.to_s}', #{ApplicationRecord.send(:sanitize_sql_array, ['?', Time.current])} 
  FROM #{Spree::Product.table_name}
  WHERE slug IS NOT NULL
  ORDER BY id
SQL

  end
end
