## Models

### User Password
```linux
rails g model user first_name last_name email password_digest
```
* User model
```ruby
has_secure_password
```
* Now it runs, we can test and assign password as
```ruby
User.create(email: 'amir', password: '1234')
```
#### Like and Activity models
```ruby
rails g model activity name schedule url_img 
```
```ruby
rails g model like user:references activity:references
```
* Activity Model
```ruby
  has_many :likes, dependent: :nullify
  has_many :liked_user, through: :likes, source: :user
```
* And same for User Model
```ruby
  has_many :likes, dependent: :nullify
  has_many :liked_activity, through: :likes, source: :activity
```
* To create a chain we can have
```ruby
a = Activity.last
b = User.last
a.liked_user << b
```
* To access all users that likes an activity we can have below and in order to travers we can cancate `.each` to end and go through 
```ruby
a = Activity.last
a.liked_user
```
* `Like` model when creating with references is automatically assigned, only if we want them be unique we can add constrains as
```ruby

```
* Then rails db:migrate can run!

## Seed 
* Simple seed can be written as 
```ruby
User.destroy_all
rand(2..5).times do
   User.create(
     email: Faker::Internet.email,
     password: "1234"
   )
 end
   users = User.all
puts Cowsay.say("Created #{users.count} users", :tux)   
```

## View page
* inside activity index add list of all acitvities 
```ruby
<%   @activities.each do |act| %><br />
   <% like_exist = false %>
     <%= image_tag act.url_img , size%>
           <!-- For each activity check in the list of all users that liked this activity to find whether is the current user  -->
    <% act.liked_user.each do |usr|  %>
        <% if (@liked != nil && usr.id == current_user.id) %>
              <% like_exist = true %>
              <%=  icon('fas', 'heart',  id: 'my-icon', class: 'strong') %>
              <%= link_to "Remove",  activity_like_path(act.id, current_user.id), method: :delete %>
         <% end %>
     <% end %>
     <% if like_exist == false %>
         <%=  icon('far', 'heart',  id: 'my-icon', class: 'strong') %>
       <%= link_to "Add", activity_likes_path(act.id), class: "icon-big", method: :post  %>
     <% end %>
```
## Controllers
* Likes controller would be like 
```ruby
def create
   like          = Like.new
   activity      = Activity.find params[:activity_id]
   like.activity = activity
   like.user     = User.first # current_user
   if like.save
     redirect_to root_path, notice: "Thanks for liking!"
   else
     redirect_to root_path, alert: "Can't like! Liked already?"
   end
 end

 def destroy
    like = Like.find_by user_id: params[:id], activity_id: params[:activity_id]
    like.destroy
   redirect_to root_path, notice: "Like removed!"
 end
```
* Activities controller would be like (imaging a user John is created by seed sicne we have not assign users authentications and sessionp[:user_id]
```ruby
def index
    @activities = Activity.order(:name)
     # find_by current_user
    session[:user_id] = User.find_by(first_name: "John");
    @liked = Like.find_by(user_id: session[:user_id])
  end
```
* In application_controller we add
```ruby
def user_signed_in?
   if session[:user_id].present? && current_user.nil?
     session[:user_id] = nil
   end
   session[:user_id].present?
 end
 helper_method :user_signed_in?
   def current_user
       @current_user ||= User.find_by(id: session[:user_id])
   end
   helper_method :current_user
```
## Routs 
* The routes would be like 
```ruby
 resources :activities do
      resources :likes, only: [:create, :destroy]
 end
 root to: 'activities#index'
```

