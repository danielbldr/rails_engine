# Rails Engine

### About the Project

Solo project building a test driven API based on an e-commerce database. The application contains business logic and advanced database calls. Controllers are RESTful and adhere to the single responsibility principle.

## Local Setup

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Set up the database
```
$ bundle exec rake import
```
This task will efficiently create, migrate, and seed the database with files in the `db/data` folder

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies Used                                           

##### Ruby on Rails
##### RSpec/Capybara
##### ActiveRecord/SQL
##### Fast JSON API
##### PostgreSQL


## Versions 
`Ruby 2.5.3`

## Schema
![image](https://user-images.githubusercontent.com/50503353/82521068-e6948180-9ae2-11ea-8b00-3991f197942c.png)


