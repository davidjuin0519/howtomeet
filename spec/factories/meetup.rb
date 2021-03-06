FactoryGirl.define do
  factory :meetup do
    category_id ''
    title {Faker::Hacker.adjective}
    title_en {Faker::Hacker.adjective}
    subtitle {Faker::Lorem.sentence}
    description {Faker::Lorem.paragraph}
    day {1+Random.rand(7)}
    location {Faker::Address.city}
    called {Faker::Hacker.noun}
    cover { Rack::Test::UploadedFile.new(File.join(Rails.root, 'cover.jpg')) }
    created_at {Faker::Time.between(2.days.ago, Time.now, :morning)}
    updated_at {Faker::Time.between(2.days.ago, Time.now, :afternoon)}

    factory :meetup_with_user do
      ignore do
        user_count 5
      end

      after(:create) do |meetup, evaluator|
        FactoryGirl.create_list(:meetup_member, evaluator.user_count, meetup_id: meetup.id)
        FactoryGirl.create(:event_with_user, meetup_id: meetup.id)
      end

    end

    # factory :meetup_with_event do
    #   after(:create) do |meetup|
    #     FactoryGirl.create(:event, meetup_id: meetup.id)
    #   end
    # end

  end

end