require 'spec_helper'

describe 'Schedule Pages' do

	subject { page }
	
	describe 'New Schedule page' do
	
		let(:trainer) { FactoryGirl.create(:trainer) }
		let(:client) { FactoryGirl.create(:client) }
				
		before do 
			trainer.clients << client
			sign_in_trainer trainer
			visit client_path(client)
			click_link "New Schedule"
		end
		
		let(:submit) { "Create" }
		
		describe 'with invalid information' do
			it 'should not create a schedule' do
		  	expect { click_button submit }.not_to change(Schedule, :count)
		  end
		end
		
		describe 'with valid information'do
			before do
				fill_in "Scheduled date", 					with: "1/1/2020"
			end
			
			it 'should create a schedule' do
				expect { click_button submit }.to change(Schedule, :count).by(1)
			end
		end
	end
end
		