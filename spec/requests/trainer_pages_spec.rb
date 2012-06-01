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
end