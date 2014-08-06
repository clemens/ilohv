FactoryGirl.define do
  factory :file, class: Ilohv::File do
    sequence(:name) { |i| "File #{i + 1}" }

    file { File.open(File.expand_path('spec/fixtures/unit-test.jpg'), 'r') }
  end
end
