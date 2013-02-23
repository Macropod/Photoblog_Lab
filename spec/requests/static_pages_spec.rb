require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'PhotoBlog' }
    let(:page_title) { '' }
    let(:admin) { FactoryGirl.create(:admin) }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }

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

    describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    page.should have_selector 'title', text: full_title('')
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign Up')
    click_link "PhotoBlog"
    page.should have_selector 'title', text: full_title('')
  end
end		