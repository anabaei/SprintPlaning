
# Create Seed

* To have a list of categories put them inside seed file  
``` ruby
categories = ['Books', 'Techology', 'Computers', 'Movies', 'TV', 'Fashion', 'Music']
categories.each do |category|
  #puts "#{category} products created!"
  Category.create(name: category)
end
```
* Or we can use factorygirl 
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
* Then inside form we would have the selection list as below with values equal to ids while representating names as an attribute 
```ruby
<%= f.collection_select :category_id, Category.all, :id, :name %>
```
