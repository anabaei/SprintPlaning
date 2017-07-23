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

# Authentication
* Generate a model with fname,lname, .. and password_digest. Then inside the model add `has_secure_password`. In this way we would have password field in views and controller but in model password_digest. All these jobs are done by `bcrypt` gem
* Generate a controller for users, then create a form_for 
``` ruby
<%= form_for @user do |f| %>
```
To address the form, first we have to set `instance variable` in controller  `@user = User.new` and in routes `post('users/', to: 'users#create')` beucase default format of form_for is set to post users_path address.  
#### Create 
to read from params and create a new user we need below codes inside create action
``` ruby
input = params.require(:user).permit(:first_name, :last_name, :email, :password)
User.create(input)
```

### Validation

* We can add below validations on first line of a model
``` ruby
  validates :age, presence: true, uniqueness: true, numericality: { greater_than_or_equal_to: 10 }
```



* ...

















Tam link: https://github.com/CodeCoreYVR/bootcamp_summary_notes/blob/master/week_06/one_to_many.md
