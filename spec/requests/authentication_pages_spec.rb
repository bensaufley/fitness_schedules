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
		end
	end
	
end	
		