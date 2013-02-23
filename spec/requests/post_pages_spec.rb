require 'spec_helper'

describe "PostPages" do

  subject { page }

  describe "create post page" do
  	let(:admin) { FactoryGirl.create(:admin) }

  	before do
      	sign_in(admin)
      	visit newpost_path
    end

    it { should have_selector('h1', text: "Create a new post") }
    it { should have_selector('title', text: full_title("New post")) }

    describe "with invalid information" do
      before { fill_in 'post_text', with: "" }

      it "should not create a post" do
        expect { click_button "Post" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'post_text', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Post, :count).by(1)
      end
    end

  end

  describe "home page" do
    before { visit root_path }
    let(:admin) { FactoryGirl.create(:admin) }

    describe "with posts" do
      let(:user1) { FactoryGirl.create(:user) }
      let(:user2) { FactoryGirl.create(:user) }
      let!(:p1) {FactoryGirl.create(:post, user: user1, text: "post1") }  
      let!(:p2) {FactoryGirl.create(:post, user: user2, text: "post2") }

      describe "without being signed in" do
        it { should_not have_content(p1.text) }
      end

      describe "without being an admin" do
        before do
          sign_in(user1)
          visit root_path
        end
        it { should_not have_link "Create a new post" }
      end

      describe "when signed in" do
        before do
          sign_in(user1)
          visit root_path
        end
        it { should have_content(p1.text) }
        it { should have_content(user1.name) }
        it { should have_content(p2.text) }
        it { should have_content(user2.name) }
        #it { should have_content(user.posts.count) }
      end

      describe "when signed in as admin" do
        before do
          sign_in(admin)
          visit root_path
        end
        it { should have_link "Delete" }
        it "should delete a post" do
          expect { click_link "Delete" }.to change(Post, :count).by(-1)
        end
      end
    end

    describe "when signed in as admin" do
      before do
        sign_in(admin)
        visit root_path
      end
      it { should have_link "Create a new post" }
    end
  end

end
