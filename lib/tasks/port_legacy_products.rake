desc "Assign the first category to all products, which are already created"
task :port_legacy_product => :environment do
  Product.all.each { |product| product.categories << Category.first }
end
