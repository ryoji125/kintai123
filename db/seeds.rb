User.create!(name:  "上長A",
             email: "email99@sample.com",
             password:              "password",
             password_confirmation: "password",
             superior: true,
             employee_number: "998",
             uid: "998",
             affiliation: "管理")
User.create!(name:  "上長B",
             email: "email98@sample.com",
             password:              "password",
             password_confirmation: "password",
             superior: true,
             employee_number: "998",
             uid: "998",
             affiliation: "管理")
User.create!(name:  "管理者",
             email: "email@sample.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             employee_number: "1000",
             uid: "1000",
             affiliation: "管理")

Faker::Config.locale = :ja
5.times do |n|
  name  = Faker::Name.name
  email = "email#{n+1}@sample.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               employee_number: "#{n+1}",
               uid: "#{n+1}",
               affiliation: "営業部")
end