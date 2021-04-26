FactoryBot.define do
  factory :event do

    association :user

    title { "Название #{rand(999)}" }
    address { "Адрес #{rand(999)}"}
    datetime { Time.now }


  end
end
