desc "Assign the first category to all products, which are already created"
task :port_legacy_product => :environment do
  Product.left_outer_joins(:categories).where(categories: { id: nil }).each { |product| product.categories << Categoty.first }
end
