FactoryGirl.define do
  factory :trainer do
    sequence(:name) { |n| "Trainer #{n}" }
    sequence(:email) { |n| "trainer_#{n}@mp-trainer.com" }
    password "foobar"
    password_confirmation "foobar"
  end
  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    sequence(:email) { |n| "client_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end