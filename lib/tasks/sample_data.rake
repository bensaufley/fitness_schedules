namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		Trainer.create!(name: "Joe Trainer",
								email: "jtrainer@mp-trainer.com",
								password: "foobar",
								password_confirmation: "foobar")
		99.times do |n|
			name = Faker::Name.name
			email = "Trainer-#{n+1}@mp-trainer.com"
			password = "password"
				Trainer.create!(name: name,
												email: email,
												password: password,
												password_confirmation: password)
		end
		Client.create!(name: "Jane Client",
									email: "jclient@example.com",
									password: "foobar",
									password_confirmation: "foobar")
		99.times do |n|
			name = Faker::Name.name
			email = "Client-#{n+1}@example.com"
			password = "password"
				Client.create!(name: name,
											email: email,
											password: password,
											password_confirmation: password)
		end
	end
end
	