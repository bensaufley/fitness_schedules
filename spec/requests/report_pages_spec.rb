require 'spec_helper'

describe 'Report pages' do

	subject { page }
	
	describe 'New Report Page' do
	  let(:admin) { FactoryGirl.create(:trainer) }
	  before do
	    admin.toggle(:admin)
	    visit new_report_path
	  end
	  
	  it { should have_selector('label', text: "Email") }
	  it { should have_selector('label', text: "Start Date") }
	  it { should have_selector('label', text: "End Date") }
	  it { should have_selector('input', value: "Generate Report") }
	end

end