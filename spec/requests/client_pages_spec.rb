require 'spec_helper'

describe 'Client pages' do

	subject { page }
	
	describe 'profile page' do
		let!(:client) { FactoryGirl.create(:client) }
		let(:schedule) { client.schedules.create(scheduled_date: (Date.today + 1)) }
		before do
			sign_in_client(client)
			visit client_path(client)
		end
		
		it { should have_selector('title', text: client.name) }
		it { should have_link(schedule.scheduled_date.strftime("%d %b %Y"), href: schedule_path(schedule)) }
		
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
			let(:client1) { FactoryGirl.create(:client) }
			let(:client2) { FactoryGirl.create(:client) }
			before do
				trainer.clients << client1
				sign_in_trainer(trainer)
				visit clients_path
			end
			
			it { should have_selector('title', text: "All Clients") }
			
			
			describe 'pagination' do
				before(:all) { 30.times { FactoryGirl.create(:client) } }
				after(:all) { Client.delete_all }
				
				it 'should list each client' do
					Client.order(:name).paginate(page: 1).each do |client|
						page.should have_selector('li', text: client.name)
						page.should have_link('Train this client')
					end
				end
			end
			
			describe 'complete schedules' do
			  let(:trainer) { FactoryGirl.create(:trainer) }
			  let(:client) { FactoryGirl.create(:client) }
			  let!(:schedule) { client.schedules.create(scheduled_date: (Date.today + 1)) }
			  before do
          trainer.clients << client
          client.schedules << schedule
			    sign_in_trainer trainer
			    visit schedule_path(schedule)
			    fill_in "Email",      with: client.email
			    fill_in "Password",   with: "foobar"
			    choose("I received this training session on the scheduled date.")
          click_button "Submit"
          it { should have_selector('title', text: "Complete") }
          schedule.rendered.should be_true
        end
			end
		end
	end
end
