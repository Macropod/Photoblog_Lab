require 'spec_helper'

describe Post do
  
  let(:user) { FactoryGirl.create(:user) }
  before {@post = user.posts.new(text: "Lorem ipsum") }

  subject { @post }

  it { should respond_to(:text) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank text" do
    before { @post.text = " " }
    it { should_not be_valid }
  end

  describe "with text that is too long" do
    before { @post.text = "a" * 141 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Post.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end 
end
