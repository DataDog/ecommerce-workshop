# This migration comes from spree (originally 20161014152814)
class AddNullFalseToSpreeVariantsTimestamps < ActiveRecord::Migration[5.0]
  def change
    change_column_null :spree_variants, :created_at, false
    change_column_null :spree_variants, :updated_at, false
  end
end
