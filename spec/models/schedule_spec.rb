require 'spec_helper'

describe Schedule do

		let(:client) { FactoryGirl.create(:client) }
		before { @schedule = client.schedules.build(scheduled_date: '1/1/2020') }

	subject { @schedule }
	
	it { should be_valid }
	it { should respond_to(:scheduled_date) }
	it { should respond_to(:rendered) }
	it { should respond_to(:client) }
	it { should respond_to(:exercises) }
	it { should respond_to(:trainers) }
	
	describe 'accessible attributes' do
		it 'should not allow access to client_id' do
			expect { Schedule.new(client_id: client.id) }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
		
	describe 'when client_id is not present' do
		before { @schedule.client_id = nil }
		it { should_not be_valid }
	end
		
	describe 'when scheduled_date is not present' do
		before { @schedule.scheduled_date = '' }
		it { should_not be_valid }
	end
	
	describe "when scheduled_date is in the past (on create)" do
		before { @schedule.scheduled_date = '1/1/1970' }
		it { should_not be_valid }
	end
end
