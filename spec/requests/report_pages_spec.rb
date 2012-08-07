require 'spec_helper'

describe 'Report pages' do

	subject { page }
	
	describe 'New Report Page' do
	  let(:admin) { FactoryGirl.create(:trainer) }
	  before do
	    admin.toggle!(:admin)
	    sign_in_trainer admin
	    visit new_report_path
	  end
	  it { should have_selector('title', text: 'New Report') }
	  it { should have_selector('label', text: "Email") }
	  it { should have_selector('label', text: "Start date") }
	  it { should have_selector('label', text: "End date") }
	  it { should have_selector('input', value: "Generate Report") }
	end

end
