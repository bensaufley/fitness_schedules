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
		end
	end

end	
		