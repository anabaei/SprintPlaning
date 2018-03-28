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
