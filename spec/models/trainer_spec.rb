require 'spec_helper'

describe Trainer do
  before { @trainer = Trainer.new(name: "stuart", email: 'sterrett@mp-sportsclub.com', 
  																password: 'foobar', password_confirmation: 'foobar') }
  
  subject { @trainer }
  
  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  
  describe "When name is not present" do
    before { @trainer.name = '' }
    it { should_not be_valid }
  end
  
  describe "When email is not present" do
    before { @trainer.email = '' }
    it { should_not be_valid }
  end
  
  describe "When email already exists" do
    before do
      trainer_email_dup = @trainer.dup
      trainer_email_dup.save
    end
    
    it { should_not be_valid }
  end  
  
  describe "When password is not present" do
    before { @trainer.password = @trainer.password_confirmation = '' }  
    
    it { should_not be_valid }
  end
  
  describe "When password confirmation does not match" do
    before { @trainer.password_confirmation = 'raboof' }
    
    it { should_not be_valid }
  end
  
  describe "When password is too short" do
    before { @trainer.password = @trainer.password_confirmation = 'a' * 4 }
   
    it { should_not be_valid }
  end
  
  describe "return value of authenticate" do
    before { @trainer.save }
    let(:found_trainer) {Trainer.find_by_email(@trainer.email) }
    
    describe "With valid password" do
    	it { should == found_trainer.authenticate(@trainer.password) }
    end
    
    describe "with invalid password" do
      let(:trainer_for_invalid_password) { found_trainer.authenticate("invalid") }
      
      it { should_not == trainer_for_invalid_password }
      specify { trainer_for_invalid_password.should be_false }
    end
  end
end
