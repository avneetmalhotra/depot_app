desc "Mark users role as 'admin' for given email"
task :mark_admin, [:email_arg] => :environment do |task, args|
  users = User.where(email: args.email_arg)
  users.update(role: 'admin')
end