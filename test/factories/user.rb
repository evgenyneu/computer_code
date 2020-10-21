FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@server.com"
    end

    password  { "test123" }
    password_confirmation  { "test123" }
    word { "Hello" }
  end
end
