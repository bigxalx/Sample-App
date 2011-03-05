require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failure" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",             :with => ""
          fill_in "Email",            :with => ""
          fill_in "Password",         :with => ""
          fill_in "Confirmation",     :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",             :with => "Armin"
          fill_in "Email",            :with => "bigxalx@gmail.com"
          fill_in "Password",         :with => "foobar"
          fill_in "Confirmation",     :with => "foobar"
          click_button
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
    
    describe "sign in/out" do 
      describe "failure" do 
        it "should not sign a user in" do
          visit signin_path
          fill_in "session_email", :with => ""
          fill_in :password, :with => ""
          click_button
          response.should have_selector("div.flash.error", :content => "Invalid")
        end
      end
      
      describe "success" do
        it "should sign a user in and out" do
          user = Factory(:user)
          visit signin_path
          fill_in "session_email", :with => user.email
          fill_in :password, :with => user.password
          click_button
          controller.should be_signed_in
          click_link "Sign out"
          controller.should_not be_signed_in
        end
      end
    end
  end
  # describe "PUT 'update'" do
  # 
  #       before(:each) do
  #         @user = Factory(:user)
  #         test_sign_in(@user)
  #       end
  # 
  #       describe "failure" do
  # 
  #         before(:each) do
  #           @attr = { :email => "", :name => "", :password => "",
  #                     :password_confirmation => "" }
  #         end
  # 
  #         it "should render the 'edit' page" do
  #           put :update, :id => @user, :user => @attr
  #           response.should render_template('edit')
  #         end
  # 
  #         it "should have the right title" do
  #           put :update, :id => @user, :user => @attr
  #           response.should have_selector("title", :content => "Edit user")
  #         end
  #       end
  # 
  #       describe "success" do
  # 
  #         before(:each) do
  #           @attr = { :name => "New Name", :email => "user@example.org",
  #                     :password => "barbaz", :password_confirmation => "barbaz" }
  #         end
  # 
  #         it "should change the user's attributes" do
  #           put :update, :id => @user, :user => @attr
  #           @user.reload
  #           @user.name.should  == @attr[:name]
  #           @user.email.should == @attr[:email]
  #         end
  # 
  #         it "should redirect to the user show page" do
  #           put :update, :id => @user, :user => @attr
  #           response.should redirect_to(user_path(@user))
  #         end
  # 
  #         it "should have a flash message" do
  #           put :update, :id => @user, :user => @attr
  #           flash[:success].should =~ /updated/
  #         end
  #       end
  #     end
  
  # describe "authentication of edit/update pages" do
  # 
  #     before(:each) do
  #       @user = Factory(:user)
  #     end
  # 
  #     describe "for non-signed-in users" do
  # 
  #       it "should deny access to 'edit'" do
  #         get 'edit', :id => @user
  #         response.should redirect_to(signin_path)
  #       end
  # 
  #       it "should deny access to 'update'" do
  #         put 'update', :id => @user, :user => {}
  #         response.should redirect_to(signin_path)
  #       end
  #     end
  # 
  #         describe "for signed-in users" do
  # 
  #           before(:each) do
  #             wrong_user = Factory(:user, :email => "user@example.net")
  #             test_sign_in(wrong_user)
  #           end
  # 
  #           it "should require matching users for 'edit'" do
  #             get :edit, :id => @user
  #             response.should redirect_to(root_path)
  #           end
  # 
  #           it "should require matching users for 'update'" do
  #             put :update, :id => @user, :user => {}
  #             response.should redirect_to(root_path)
  #           end
  #         end
  #   end
end
