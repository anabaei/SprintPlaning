

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
