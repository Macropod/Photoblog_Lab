namespace :db do
  desc "Fill database with initial users"
  task initiate_users: :environment do
    admin = User.create!(name: "Macropod",
                 password: ENV['ADMIN_PSW'],
                 password_confirmation: ENV['ADMIN_PSW'])
    admin.toggle!(:admin)
  end
end