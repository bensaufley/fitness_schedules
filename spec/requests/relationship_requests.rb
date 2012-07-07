require 'spec_helper'

describe "Adding and Removing clients to trainers" do

	subject { page }
	
	let!(:trainer) { FactoryGirl.create(:trainer) }
	let!(:bound_client) { FactoryGirl.create(:client) }
	let!(:free_client) { FactoryGirl.create(:client) }
	before { trainer.clients << bound_client }
	
	describe 'Index Page' do
		before do
			sign_in_trainer trainer
			visit clients_path
		end
		
		it { should have_link('Train this client') }
	 	it { should have_link('Remove this client') }
	
		describe 'adding a client' do
			before { click_link('Train this client') }
			it { should have_selector('title', text: free_client.name) }
			
			describe "trainer's profile" do
				before { visit trainer_path(trainer) }
				it { should have_link(free_client.name) }
			end
		end
		
		describe 'removing a client' do
			before { click_link('Remove this client') }
			it { should have_selector('title', text: trainer.name) }
			it { should_not have_link(bound_client.name) }
		end
		
	end
	
	describe 'Trainer profile' do
		before do
			sign_in_trainer trainer
			visit trainer_path(trainer)
		end
		
		it { should have_link(bound_client.name) }
		it { should have_link('Remove client') }
	
		describe 'removing client' do
			before { click_link('Remove client') }
			
			it { should_not have_link(bound_client.name) }
		end
	end
	
end