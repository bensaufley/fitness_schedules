require 'spec_helper'

describe Exercise do
	before do
		@exercise = Exercise.new(circuit: 1, order: 1, name: "pullups", 
														 weight_or_intensity: "50lbs assist", reps_or_duration: "8", schedule_id: 1)
	end

	subject { @exercise }
	
		it { should be_valid }
		it { should respond_to(:circuit) }
		it { should respond_to(:order) }
		it { should respond_to(:name) }
		it { should respond_to(:weight_or_intensity) }
		it { should respond_to(:reps_or_duration) }
		it { should respond_to(:schedule) }
		
		
		describe 'without name' do
			before { @exercise.name = '' }
			it { should_not be_valid }
		end
		
		describe 'without weight_or_intensity' do
			before { @exercise.weight_or_intensity = '' }
			it { should_not be_valid }
		end
		
		describe 'without reps_or_duration' do
			before { @exercise.reps_or_duration = '' }
			it { should_not be_valid }
		end
		
		describe 'without schedule' do
			before { @exercise.schedule_id = '' }
			it { should_not be_valid }
		end
		
end