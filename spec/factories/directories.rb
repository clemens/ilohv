FactoryGirl.define do
  factory :directory, class: Ilohv::Directory do
    sequence(:name) { |i| "Directory #{i + 1}" }
  end
end
