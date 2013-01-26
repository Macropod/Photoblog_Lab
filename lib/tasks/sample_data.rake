namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Initia Examplus",
                 email: "initia@mail.org",
                 password: "Initia",
                 password_confirmation: "Initia")
    admin.toggle!(:admin)
    99.times do |n|
      name  = ('a'..'z').to_a.shuffle[0,8].join
      email = "#{name}@mail.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end