FactoryGirl.define do
  factory :file, class: Ilohv::File do
    sequence(:name) { |i| "File #{i + 1}" }
  end
end
