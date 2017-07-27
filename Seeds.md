
# Create Seed

* To have a list of categories put them inside seed file  
``` ruby
categories = ['Books', 'Techology', 'Computers', 'Movies', 'TV', 'Fashion', 'Music']
categories.each do |category|
  #puts "#{category} products created!"
  Category.create(name: category)
end
```
* Then inside form we would have the selection list as below with values equal to ids while representating names as an attribute. Now in params there is `:category_id` with value
```ruby
<%= f.collection_select :category_id, Category.all, :id, :name %>
```

* In seeds we can use factorygirl 
Create users 
```ruby
PASSWORD = 'supersecret'
User.destroy_all
Idea.destroy_all

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}-#{last_name.downcase}@example.com",
    password: PASSWORD
  )
```
* Or we can create users as belwo 
``` ruby
20.times do
  user = Faker::StarWars.character
  email = user.delete(' ').downcase
  names = user.split(' ')

  User.create(
    email: "#{email}@cohort19.com",
    first_name: names.first,
    last_name: names.last,
    password: '12345',
    #password_confirmation: '12345'
  )
end
```
* It is recommended to clean up database and then run everytime, so put in first line
```ruby
  Category.destroy_all
  User.destroy_all
```
#### One to Many relation
* Each user has many idea and each idae belongs to each. So in idea table there is a foreign key for user_id. To address a random user we use `sample` function which randomly takes one object. 

```ruby
users = User.all

100.times do
  idea = Idea.create(
    title: Faker::ChuckNorris.fact,
    des: Faker::Hacker.say_something_smart,
    user: users.sample
  )

 # idea.likers = users.shuffle.slice(0..rand(users.count))
end
```

### Display with Cowsay
```ruby
puts Cowsay.say("Created #{users.count} users", :tux)
puts Cowsay.say('Created 100 questions', :cow)
```


