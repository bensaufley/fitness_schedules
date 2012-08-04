require 'spec_helper'

describe Client do
	
	before do
		@client = Client.new(name: "stuart", email: "stuart@example.com", 
													password: 'foobar', password_confirmation: 'foobar')
	end
	
	subject { @client }
	
	it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
	it { should respond_to(:trainers) }
	it { should respond_to(:schedules) }
  
  describe "When name is not present" do
    before { @client.name = '' }
    it { should_not be_valid }
  end
  
  describe "When email is not present" do
    before { @client.email = '' }
    it { should_not be_valid }
  end
  
  describe "When email already exists" do
  	before do 
  		client2 = @client.dup
	  	client2.save
  	end
  	it { should_not be_valid }
  end
  
  describe "When password is not present" do
    before { @client.password = @client.password_confirmation = '' }
    it { should_not be_valid }
  end
  
  describe "When password confirmation does not match" do
  	before { @client.password_confirmation = 'raboof' }
  	it { should_not be_valid }
  end
  
  describe "When password is not long enough" do
  	before { @client.password = @client.password_confirmation = 'a' * 5 }
  	it { should_not be_valid }
  end
  
  describe "return value of authenticate" do
    before { @client.save }
    let(:found_client) {Client.find_by_email(@client.email) }
    
    describe "With valid password" do
    	it { should == found_client.authenticate(@client.password) }
    end
    
    describe "with invalid password" do
      let(:client_for_invalid_password) { found_client.authenticate("invalid") }
      
      it { should_not == client_for_invalid_password }
      specify { client_for_invalid_password.should be_false }
    end
    
    describe "when assigning trainer id" do
    	before do
    		@client.trainer_id = 1 
    	end.should { raise_error(ActiveModel::MassAssignmentSecurity::Error) }
    end
    
  end
  
    
		
end
