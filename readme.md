# One To Many

* We have post and comments models 
* Each post has many comments, so we add post reference to comments  
``` ruby
    rails g migration add_post_to_comment post:references  
``` 
* To allow having some comments not belong to posts, inside comment model we add
``` ruby
belongs_to :post, optional: true
````
* To avoid cascade delete and keep comments even if a post of that were removed we add below to post model  
``` ruby
has_many :comments, dependent: :nullify 
````
`CASCADE`
Whenever rows in the master (referenced) table are deleted, the respective rows of the child (referencing) table with a matching foreign key column will get deleted as well. This is called a cascade delete 

* define routes with each id to be able to send each post with its whole params into show action 
``` ruby
get "/posts/:id" => "posts#show" 
```
* then anytime it links to show, then it contains applicable info. So to see it we pass params[:id] inside show action to a local variable and display it in show page. 
* A list of posts with link to show each one. see the params p is passing 
``` ruby
<% @posts.each do |p| %>
   <%= link_to p.title, post_path(p) %>
   <%= link_to 'Edit', edit_post_path(p) %>
   <%= link_to 'Delete', post_path(p), method: :delete %>
 <% end %>
```
* Then we create nested resource comments inside posts to go next level
* now in each page we can show all comments related to that post, show action inside post would be like this
``` ruby
def show
  	@post = Post.find params[:id]
  	@comments = Comment.where(post_id: params[:id])
  end 
```

## Authentication
* Generate a model with fname,lname, .. and password_digest. Then inside the model add `has_secure_password`. In this way we would have password field in views and controller but in model password_digest. All these jobs are done by `bcrypt` gem
* Generate a controller for users, then create a form_for 
``` ruby
<%= form_for @user do |f| %>
```
To address the form, first we have to set `instance variable` in controller  `@user = User.new` and in routes `post('users/', to: 'users#create')` beucase default format of form_for is set to post users_path address.  
#### Create 
To read from params and create a new user we need to tell activerecord which forms is requires and which entities are permited and then creaet a new data 
``` ruby
input = params.require(:user).permit(:first_name, :last_name, :email, :password)
User.create(input)
redirect_to home_path, notice: 'Thank you for signing up!' 
```
Also inorder to see the flash message in new page when redirecting, we pass an argument to notice: or alert then inside the flash hash they display. In layout we would have something like this
```ruby
<% if flash[:notice] %>
    <div> <%= flash[:notice] %></div>
     <% elsif flash[:alert] %> <div><%= flash[:alert] %></div>
<% end %>
```
To fadeout alert, in view home page we add this 
```javascript
  $(".alert").fadeOut(3000 );
```
#### Sign in 
 * To sign in we need form_tag instead of form_for, and we need to make tag labels as
 ```ruby
 <%= form_tag users_index_path do  %>
	<%= label_tag :email %>
	<%= email_field_tag :email %>
    <%= label_tag :password %>
	<%= password_field_tag :password %>
	<%= submit_tag %> 
<% end %>
``` 

* In routes we define `post('findit/', to: 'users#find')` destination of submiting form defined in routes as getting `findit` and direct it to `users#find` inside find action users contrller we have
 ```ruby
     theuser = User.find_by(email: params[:email])
     if (theuser.authenticate(params[:password]))
     session[:user_id] = theuser.id
    end 
 ```
 * First theuser finds if there is any user with assoiciated email, then initialize the `session[:user_id]` which is in default with Rails.

Notice: params[:email] is different than params.require(:email) which is nested hash and the first one is not
## Authorization
* To authorize users we check the `session[:user_id]` by defining an action which is know for rails. Then the return value is instance variable @current_user. It checks if it is initialize then skip it otherwise find a user by id from database. To be accessible through all views define it in applicaiton controller. 
```ruby
def current_user
   @current_user ||= User.find_by(id: session[:user_id])
end
``` 
* Then to show/hide a section just need add if condition `if (current_user.present?)` in views.
in some cases current_user is nil but session still keeps the old user, therefore we create a more reliable function as signin 
https://github.com/anabaei/codeCore/blob/master/Day25_1toMany_JS/Answer_qustions_1toMany/app/controllers/application_controller.rb
* To sign out 
```ruby
def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end
```
* To address we hace 
```ruby
<%= link_to 'Sign Out', session_path, method: :delete %>
```
* CanCan example:
https://github.com/CodeCoreYVR/awesome_answers_jun_2017/tree/master/app/controllers/admin

### Validation

* We can add below validations on first line of a model
``` ruby
  validates :age, presence: true, uniqueness: true, numericality: { greater_than_or_equal_to: 10 }
```
* Then inside 


* ...

we can pass a local variabl as an instance @ to templates. 
render :index, :locals => { :stuff => @stuff } 

### TDD
*  rails generate rspec:install
*  gem 'nyan-cat-formatter'
* Add below to .rspec file 
```ruby
--color
--require spec_helper
--format NyanCatFormatter
```

https://github.com/CodeCoreYVR/bootcamp_summary_notes/blob/master/week_05/rspec_with_rails_models.md

#### MiniTest 
####  A base test is a kind of unit testing for checking ruby files, models, databases
#### Above that we have another layer which we have more functionality testing  controllers. Since controllers are brought everything togather we test if everything is render correctly or user has been redirected or the response to the user is authorized
#### another layer above that is functional test and testing as if a user is actually changing things, clicking on browser.  

# TDD with RSPECT 
it uses for Rails app and has its own features to help testing 
#### Create RSPEC_Demo

* To manually created we have 
after adding gem 'rspec' into Gemfile

      Rails new rspec_demo -T
      Install rspec gem 
      Rails g rspec install

we can testing controllers, models comprehensively by rspec to see what they renders to views which model is accessible etc ..

setup databse and environment for our testing
create a model and validation of that model

    rails db:create RAILS_ENV = test
    rails g model user first_name last_name username email password_digest 
    rails g rspec:model user // which recreate the file
    
    
 Right now we can test by typing rspec which of course is empty right now!

#### Now automatically it created rspec folder, and inside rspec folder there is model which created inside that model rspec helper where we create our test.
    
#### To run on specific line we have
 to run our test on rails we can just run rspec, if we want to use it colorfull we deploy -p    
    
    rspec      
    rspec rspec/models/user_spec.rb:6

#### To test we write test command in spec/models/user.rb. Whenever an instance of a class is created then Rails exactly goes into the model of that class therefor we need to put all validations inside that model and then we access to all methods of that model.   It knows should go to which model. 
##### Describe is a method to break down our tests into sections and 'it' is a method and everything between do end is a block to do test, the block  is like a call back. 

For example inside : 
inside /spec/models/user_spec.rb 

    require 'rails_helper'
    
    # User is a name of model class, 
    RSpec.describe User, type: :model do 
      
      #test last_mame validation
      describe 'last_name Exist?' do
	        it('last_name must be exist!') do
		        u = User.new
		        u.valid?
		        expect(u.errors).to have_key(:last_name)
	        end 
       end
    
    end 

inside the model/user.rb 

	  validates :email, presence: true, uniqueness: true
	  validates :first_name, :last_name, presence: true

	  def full_name
		"#{first_name} #{last_name}"
	  end 

#### Beside checking vlidation, we can check the functionality like this. We check functionality of full_name. 
#### We add # in front of the name of method as convention to define a function. 

     describe '#full_name'
	    it 'combines first_name and last_name' do
	     u = User.new email: 'test@test.ca', first_name: 'Jon', last_name: 'Snow'
	     
            # then (use the full_name)
            expected_value = u.full_name;
            expect(expected_value).to eq('Jon Snow');
    
     end 
#### All above were inside  RSpec model do therefore they go directly to that model.
https://github.com/anabaei/codeCore/blob/master/Day31_RailsAdvance/Rails_Advance.js


usfulle links:
https://github.com/CodeCoreYVR/bootcamp_summary_notes/blob/master/week_05/rspec_with_rails_models.md
https://relishapp.com/rspec/rspec-expectations/v/3-6/docs/built-in-matchers
















Tam link: https://github.com/CodeCoreYVR/bootcamp_summary_notes/blob/master/week_06/one_to_many.md
