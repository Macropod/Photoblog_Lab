FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@mail.org"}   
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end

  factory :post do
    text "Lorem ipsum"
    user
  end
end