FactoryGirl.define do
  factory :user do
    name     "Hubert Hubertus"
    email    "hubert@hubertus.com"
    password "foobar"
    password_confirmation "foobar"
  end
end