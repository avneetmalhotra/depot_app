# Query Interface
#Build queries for following
# - Get All products which are present in atleast one line_item
## > Product.joins(:line_items).distinct 

# - Get array of product titles which are present in atleast one line item
## > Product.joins(:line_items).distinct.pluck(:title)