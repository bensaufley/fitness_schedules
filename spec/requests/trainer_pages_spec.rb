'require spec_helper'

describe 'trainer pages' do
	subject { page }
	
	describe 'profile page' do
		let(:test_trainer) { FactoryGirl.create(:trainer) }
		let(:test_client) { FactoryGirl.create(:client, trainer: test_trainer) }
		before { visit trainer_path(test_trainer) }
		
		it { should have_selector('title', text: test_trainer.name) }
		it { should have_content(test_trainer.clients) }
		
		
	end
	
	describe 'new trainer page' do
		before { visit new_trainer_path }
		let(:submit) { "Create my account" }
		
		describe 'with invalid information' do
			it 'should not create a user' do
				expect { click_button submit }.not_to change(Trainer, :count)
			end
		end
		
		describe 'with valid information' do
			before do
				fill_in "Name", 			with: "Joe Trainer"
				fill_in "Email", 			with: "jtrainer@mp-trainer.com"
				fill_in "Password", 	with: "foobar"
				fill_in "Password confirmation", with: "foobar"
			end
			
			it 'should create a user' do
				expect { click_button submit }.to change(Trainer, :count).by(1)
			end
		end
	
	end
		
		
end