# Todoes API

[todoes-api](https://secret-cove-74181.herokuapp.com/)

- Ruby [2.6.3](https://github.com/klaudiasob/todoes/blob/master/.ruby-version#L1)
- Rails [6.0.2](https://github.com/klaudiasob/todoes/blob/master/Gemfile#L9)

## Install
#### 1. Check out the repository

```bash
git clone git@github.com:klaudiasob/todoes.git
```

#### 2. Update database.yml file

Update the database configuration as required.

#### 3. Create and setup the database

Run the following commands to setup the database and populate it with seed data.

```ruby
bundle exec rake db:setup
```

#### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

#### JWT Authentication
- The application uses `devise-jwt` gem. A user authenticates through `POST /users/sign_in` request.
- If the authentication succeeds, a JWT token is dispatched to the client in the `Authorization` response header.
- The client can use this token to authenticate following requests for the same user, providing it in the Authorization request header, also with format `Bearer #{token}`.
#### Test data
You can use following credentials with the `POST /users/sign_in` endpoint.
- email: `user@example.com`
- password: `password`