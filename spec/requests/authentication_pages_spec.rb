require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign In') }
    it { should have_selector('title', text: 'Sign In') }

    it "should have correct links" do
    	visit signin_path
    	click_link "Sign up now!"
    	page.should have_selector 'title', text: full_title('Sign Up')
    end
  end

  describe "sign in" do

  	before { visit signin_path }

  	let(:submit) { "Sign In" }

  	describe "with invalid information" do

  	  describe "after submission" do
  	    before { click_button submit }

  	    it { should have_selector('title', text: 'Sign In') }
  	    it { should have_selector('div.alert-error') }
    	  describe "after visiting another page" do
    		  before { click_link "Home" }
    		  it { should_not have_selector('div.alert.alert-error') }
    		end
  	  end
  	end

	  describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in(user) }

      it { should have_selector('title', text: user.name) }
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link('Sign In') }
      end
    end
  end

  describe "without being signed in" do
    before { visit signin_path }
    it { should_not have_link('Users') }
    it { should_not have_link('Profile') }
    it { should_not have_link('Settings') }
    it { should_not have_link('Sign Out') }
    it { should have_link('Sign In') }
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the user overview page" do
          before {visit users_path }
          it { should have_selector('title', text: 'Sign In') }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('h1', text: "Update your profile")
          end
        end

        describe "after subsequent sign-ins" do
          before do
            click_link "Sign Out"
            click_link "Sign In"
            fill_in "Email",    with: user.email
            fill_in "Password", with: user.password
            click_button "Sign In"
          end

          it "should render the user page" do
            page.should have_selector('h1', text: user.name)
          end

        end
      end
    end

    describe "for signed-in users" do
      let(:signed_in_user) { FactoryGirl.create(:user) }
      let(:user_to_be_edited) { FactoryGirl.create(:user, email: "other@blah.com") }
      
      before do
      	sign_in(signed_in_user)
      end

      describe "in the Users controller" do

        describe "visiting the edit page of a different user" do
          before { get edit_user_path(user_to_be_edited) }
          specify { response.should redirect_to(root_path) }
        end

        describe "submitting to the update action of a different user" do
          before { put user_path(user_to_be_edited) }
          specify { response.should redirect_to(root_path) }
        end

        describe "visiting the new page" do
          before { get signup_path }
          specify { response.should redirect_to(root_path) }
        end

        describe "submitting a create request" do
          before { post signup_path }
          specify { response.should redirect_to(root_path) }
        end
      end
    end

    describe "as non admin" do
      let(:user) { FactoryGirl.create(:user) }
      let(:not_admin) { FactoryGirl.create(:user) }

      before { sign_in not_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }        
      end
    end

    describe "as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      before { sign_in admin }

      describe "submitting a DELETE request to the Users#destroy action for himself" do
        before { delete user_path(admin) }
        specify { response.should redirect_to(root_path) }        
      end
    end
  end
end
