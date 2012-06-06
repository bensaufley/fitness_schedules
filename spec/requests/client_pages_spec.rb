require 'spec_helper'

describe 'Client pages' do

	subject { page }
	
	describe 'profile page' do
		let(:client) { FactoryGirl.create(:client) }
		before do
			sign_in_client(client)
			visit client_path(client)
		end
		
		it { should have_selector('title', text: client.name) }
	end
	
	describe 'new client page' do
		before { visit new_client_path }
		let(:submit) { "Create my account" }
		
		describe 'with invalid information' do
			it 'should not create a user' do
		  	expect { click_button submit }.not_to change(Client, :count)
		  end
		end
		
		describe 'with valid information'do
			before do
				fill_in "Name", 					with: "Joe Client"
				fill_in "Email", 					with: "joeclient@example.com"
				fill_in "Password", 			with: "foobar"
				fill_in "Password confirmation", with: "foobar"
			end
			
			it 'should create a user' do
				expect { click_button submit }.to change(Client, :count).by(1)
			end
		end
	end
	
	describe 'index page' do
		
		describe 'for non-signed-in user' do
			before { visit clients_path }
			it { should have_selector('title', text: "Sign in") }
		end
		
		describe 'for signed-in client' do
			let(:client) { FactoryGirl.create(:client) }
			before do
				sign_in_client(client)
				visit clients_path
			end
			
			it { should have_selector('title', text: "Sign in") }
		end
		
		describe 'for a signed-in trainer' do
			let(:trainer) { FactoryGirl.create(:trainer) }
			let!(:client) { FactoryGirl.create(:client) }
			before do
				sign_in_trainer(trainer)
				visit clients_path
			end
			
			it { should have_selector('title', text: "All Clients") }
			it { should have_link(client.name, href: client_path(client)) }
		end
	end
end
