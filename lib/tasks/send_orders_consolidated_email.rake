desc " send all of the users a consolidated email of all the orders and items."
task :send_orders_consolidated_email => :environment do
  User.includes(orders: [:line_items]).each do |user|
    UserMailer.all_orders(user).deliver_now if user.orders.exists?
  end
end