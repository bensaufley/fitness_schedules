require 'spec_helper'

describe Schedule do
	before { @schedule = Schedule.new(scheduled_date: '1/1/2020') }
	
	subject { @schedule}
	
	it { should be_valid }
	it { should respond_to(:scheduled_date) }
	it { should respond_to(:rendered) }
	
	describe 'when scheduled_date is not present' do
		before { @schedule.scheduled_date = '' }
		it { should_not be_valid }
	end
	
	describe "when scheduled_date is in the past (on create)" do
		before { @schedule.scheduled_date = '1/1/1970' }
		it { should_not be_valid }
	end
end
