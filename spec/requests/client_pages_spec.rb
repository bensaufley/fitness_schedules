require 'spec_helper'

describe 'Client pages' do

	subject { page }
	
	describe 'profile page' do
		let(:client) { FactoryGirl.create(:client) }
		before { visit client_path(client) }
		
		it { should have_selector('title', text: client.name) }
	end
	
end
