class RemoveCheckboxesFromMarkers < ActiveRecord::Migration
  def change
    remove_column :markers, :dog, :boolean
    remove_column :markers, :cat, :boolean
    remove_column :markers, :mold, :boolean
    remove_column :markers, :bees, :boolean
    remove_column :markers, :perfume, :boolean
    remove_column :markers, :oak, :boolean
    remove_column :markers, :dust, :boolean
    remove_column :markers, :smoke, :boolean
    remove_column :markers, :gluten, :boolean
    remove_column :markers, :peanut, :boolean
  end
end
