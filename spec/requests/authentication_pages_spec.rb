require 'spec_helper'

describe 'Authentication Pages' do
	subject { page }
	
	describe 'Sign in page' do
		before { visit signin_path }
		
		it { should have_selector('title', text: 'Sign in') }
		it { should have_selector('option', text: 'Trainer') }
		it { should have_selector('option', text: 'Client') }
		
		describe 'with invalid information' do
			before { click_button 'Sign in' }
			
			it { should have_selector('title', text: 'Sign in') }
			it { should have_selector('div.alert.alert-error', text: "Invalid") }
			
			describe 'after visiting another page' do
				before { visit root_path }
				
				it { should_not have_selector('div.alert.alert-error', text: "Invalid") }
			end
		end
		
		describe 'with valid trainer information' do
			let(:trainer) { FactoryGirl.create(:trainer) }
			before do
				select "Trainer", :from => "user_type"
				fill_in "Email", 						with: trainer.email
				fill_in "Password", 				with: trainer.password
				click_button "Sign in"
			end
		
			it { should have_selector('title', text: trainer.name) }
			it { should have_link('Sign out', href: signout_path) }
			
			describe 'after signout' do
				before { click_link 'Sign out' }
				
				it { should have_link('Sign in', href: signin_path) }
			end
		end
		
		describe 'with valid client information' do
			let(:client) { FactoryGirl.create(:client) }
			before do
				select "Client", :from => "user_type"
				fill_in "Email", 							with: client.email
				fill_in "Password", 					with: client.password
				click_button "Sign in"
			end
			
			it { should have_selector('title', text: client.name) }
			it { should have_link('Sign out', href: signout_path) }
			
			describe 'after signout' do
				before { click_link 'Sign out' }
				
				it { should have_link('Sign in', href: signin_path) }
			end
		end
	end
	
	describe 'authorization' do
	
		describe 'for not-signed-in users' do
			let(:client) { FactoryGirl.create(:client) }
			let(:trainer) { FactoryGirl.create(:trainer) }
			
			describe 'in the Trainers controller' do
				before { visit trainer_path(trainer) }
				it { should have_selector('title', text: 'Sign in') }
			end
			
			describe 'in the Clients controller' do
				before { visit client_path(client) }
				it { should have_selector('title', text: 'Sign in') }
			end
		end
		
		describe 'for wrong user' do
		
			describe 'Trainer Profile' do
				let(:trainer) { FactoryGirl.create(:trainer) }
				let(:wrong_trainer) { FactoryGirl.create(:trainer) }
				before do
					sign_in_trainer wrong_trainer
					visit trainer_path(trainer)
				end
				
				it { should have_selector('title', text: "Error: Not Authorized") }
			
			end
			
			describe 'Client Profile' do
			let(:client) { FactoryGirl.create(:client) }
				let(:wrong_client) { FactoryGirl.create(:client) }
				before do
					sign_in_client wrong_client
					visit client_path(client)
				end
				
				it { should have_selector('title', text: "Error: Not Authorized") }
			end
		end
				
	end
	
	
end	
		