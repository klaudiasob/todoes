# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    association :user

    title { FFaker::CheesyLingo.sentence }
    description { FFaker::CheesyLingo.title }
    finished { FFaker::Boolean.random }
    uuid { SecureRandom.uuid }

    trait :not_finished do
      finished { false }
    end
  end
end
