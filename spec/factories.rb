FactoryGirl.define do
  factory :trainer do
    name     "Joe Trainer"
    email    "trainer@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
  factory :client do
    name     "Joe Client"
    email    "client@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end