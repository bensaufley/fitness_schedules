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
			it { should have_link('Profile', href: trainer_path(trainer)) }
			
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
			it { should have_link('Profile', href: client_path(client)) }
			
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
			
			describe 'when attempting to visit a protected page' do
				before do
					visit clients_path 
          select "Trainer", :from => "user_type"
					fill_in "Email", with: trainer.email
					fill_in "Password", with: trainer.password
					click_button "Sign in"
				end
				  
				it { should have_selector('title', text: "All Clients" ) }
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
		
		describe 'for the client.trainer client profile page' do
			let(:client) { FactoryGirl.create(:client) }
			let(:trainer) { FactoryGirl.create(:trainer) }
			before do
				trainer.clients << client
				sign_in_trainer trainer
				visit client_path(client)
			end
			
			it { should have_selector('title', text: client.name) }
		end
	end
	
	describe 'for schedule page owned by client and trainer' do
	  let(:client) { FactoryGirl.create(:client) }
	  let(:trainer) { FactoryGirl.create(:trainer) }
	  let(:schedule) { client.schedules.create(scheduled_date: Date.tomorrow, trainer_id: trainer.id) }
	  
	  describe 'client' do
	    before do
  	    sign_in_client client	  
  	    visit schedule_path(schedule)
  	  end
  	  it { should have_selector('td', text: "Circuit") }
  	end
  	
  	describe 'trainer' do
  	  before do
  	    trainer.clients << client
  	    sign_in_trainer trainer
  	    visit schedule_path(schedule)
  	  end
  	  it { should have_selector('td', text: "Circuit") }
  	end
  end
  	  
	describe 'for a schedule page not owned by (client.trainer)' do
	  let(:client) { FactoryGirl.create(:client) }
	  let(:trainer) { FactoryGirl.create(:trainer) }
	  let(:other_client) { FactoryGirl.create(:client) }
	  let(:schedule) { other_client.schedules.create(scheduled_date: Date.tomorrow, trainer_id: (trainer.id + 1)) }
	  
	  describe 'client' do
      before do
        trainer.clients << client
        sign_in_trainer trainer
        visit schedule_path(schedule)
      end
      it { should have_content('You are not authorized to view that page') }
    end
  
    describe 'trainer' do
      before do
        sign_in_client client
        visit schedule_path(schedule)
      end
      it { should have_content('You are not authorized to view that page') }
    end
  end
	
	describe 'for a completed/cancelled schedule page' do
	  let(:client) { FactoryGirl.create(:client) }
	  let(:trainer) { FactoryGirl.create(:trainer) }
	  let(:schedule) { client.schedules.create(scheduled_date: Date.tomorrow, trainer_id: trainer.id) }
	  before do 
	    sign_in_trainer trainer
	    trainer.clients << client
	    schedule.rendered = true
	    visit edit_schedule_path(schedule)
	  end
	  it { should have_selector('div.alert.alert-alert') }
	end
	    
	
	describe 'for new trainer page' do
	  
	  describe 'for admin' do
	    let(:trainer) { FactoryGirl.create(:trainer) }
	    before do 
	      trainer.toggle!(:admin)
	      sign_in_trainer trainer
	      visit new_trainer_path
	    end
	    
	    it { should have_selector('title', text: 'New') }
	  end
	    
	  describe 'for non-admin' do
	    let(:trainer) { FactoryGirl.create(:trainer) }
	    before do
	      sign_in_trainer trainer
	      visit new_trainer_path
	    end
	    
	    it { should have_content("not authorized") }
	  end
	
	end
  
  describe 'access to reporting pages' do
    let(:trainer) { FactoryGirl.create(:trainer) }
    let(:admin) { FactoryGirl.create(:trainer) }
    
    describe 'reports#new for non-admin' do
      before do
        sign_in_trainer trainer
        visit new_report_path
      end
      
      it { should have_content("not authorized") }
    end
    
    describe 'reports#show for non-admin' do
      before do
        sign_in_trainer trainer
        visit reports_show_path
      end
      
      it { should have_content("not authorized") }
    end
    
    describe 'reports#new for admin' do
      before do
        admin.toggle!(:admin)
        sign_in_trainer admin
        visit new_report_path
      end
      
      it { should have_selector('input', value: "Generate Report") }
    end
      
    describe 'reports#show for admin' do
      let(:submit) { "Generate Report" }
      before do
        sign_in_trainer admin
        visit new_report_path
        click_button submit
      end
      
      it { should have_selector('td', text: "Client") }
    end
  end     	
end	
		