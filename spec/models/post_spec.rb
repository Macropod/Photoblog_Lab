# == Schema Information
#
# Table name: posts
#
#  id                   :integer          not null, primary key
#  text                 :string(255)
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  access_token         :string(255)
#  family               :boolean          default(FALSE)
#  friends              :boolean          default(FALSE)
#  others               :boolean          default(TRUE)
#  gallery_id           :integer
#  sort_index           :integer          default(0)
#

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
