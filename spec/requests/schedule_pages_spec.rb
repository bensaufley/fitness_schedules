require 'spec_helper'
require 'date'

describe 'Schedule Pages' do

	subject { page }
	
	describe "schedule order" do
	  let!(:client) { FactoryGirl.create(:client) }
	  let!(:schedule1) { client.schedules.create(scheduled_date: (Date.today + 1)) }
	  let!(:schedule2) { client.schedules.create(scheduled_date: (Date.today + 2)) }
	  before { client.schedules.should == [schedule2, schedule1] }
	end
	
	describe "exercise order" do
	  let(:client) { FactoryGirl.create(:client) }
	  let(:schedule) { client.schedules.create(scheduled_date: (Date.today + 1)) }
	  let(:ex1) { schedule.exercises.create( circuit: 1, ex_order: 2, name: 'pullups', weight_or_intensity: 'no assist', 
	                                        reps_or_duration: '12') }
 	  let(:ex2) { schedule.exercises.create( circuit: 1, ex_order: 1, name: 'pushups', weight_or_intensity: 'no assist', 
	                                        reps_or_duration: '12') }	
	  let(:ex3) { schedule.exercises.create( circuit: 2, ex_order: 1, name: 'dips', weight_or_intensity: 'no assist', 
	                                        reps_or_duration: '12') }
 	  let(:ex4) { schedule.exercises.create( circuit: 1, ex_order: 3, name: 'reverse pushups', weight_or_intensity: 'no assist', 
	                                        reps_or_duration: '12') }
	  let(:ex5) { schedule.exercises.create( circuit: 2, ex_order: 2, name: 'inverted situps', weight_or_intensity: 'no assist', 
	                                        reps_or_duration: '12') }	  
	  before do
	    sign_in_client client
	    visit schedule_path(schedule)
	  end
	  
	  it { should have_selector("tbody tr:nth-child(1)", content: ex2.name) }
	  it { should have_selector("tbody tr:nth-child(2)", content: ex1.name) }
	  it { should have_selector("tbody tr:nth-child(3)", content: ex4.name) }
	  it { should have_selector("tbody tr:nth-child(4)", content: ex3.name) }
	  it { should have_selector("tbody tr:nth-child(5)", content: ex5.name) }
	
	end                                      
	                                
	describe 'New Schedule page' do
	
		let(:trainer) { FactoryGirl.create(:trainer) }
		let(:client) { FactoryGirl.create(:client) }
				
		before do 
			trainer.clients << client
			sign_in_trainer trainer
			visit edit_client_path(client)
		end
		
		it { should have_link("Add Schedule") }
		
		describe "Adding a schedule" do
			before { click_link "Add Schedule" }
			it { should have_selector("select", id: 'new') }
		end
		
			
		
# 		let(:submit) { "Create" }
# 		
# 		describe 'with invalid information' do
# 			it 'should not create a schedule' do
# 		  	expect { click_button submit }.not_to change(Schedule, :count)
# 		  end
# 		end
# 		
# 		describe 'with valid information'do
# 			before do
# 				fill_in "Scheduled date", 					with: "1/1/2020"
# 			end
# 			
# 			it 'should create a schedule' do
# 				expect { click_button submit }.to change(Schedule, :count).by(1)
# 			end
# 		end
	end
	
# describe "view schedule" do
# 			let(:trainer) { FactoryGirl.create(:trainer) }
#   		let(:client) { FactoryGirl.create(:client) }
# 			let(:date) { date.strptime '1/13/2020', '%m/%d/%Y' }
# 			let(:schedule) { client.schedules.create(date: date) }
# 			let(:exercise) { schedule.exercises.create(circuit: 1, order: 1, name: 'pullups', 
# 																			weight_or_intensity: 'red rubber band', reps_or_duration: '8') }
# 			before do
# 				trainer.clients << client
# 				sign_in_trainer trainer
# 				visit schedule_path(schedule)
# 			end
# 			
# 			it { should have_selector("td", text: "Circuit") }
# 			it { should have_selector("td", text: "pullups") }
# 		end
# 			
end
		