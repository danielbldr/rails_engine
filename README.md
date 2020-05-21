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
```
Ruby on Rails
RSpec/Capybara
ActiveRecord/SQL
Fast JSON API
PostgreSQL
```

## Versions 
`Ruby 2.5.3`

## Schema
![image](https://user-images.githubusercontent.com/50503353/82521068-e6948180-9ae2-11ea-8b00-3991f197942c.png)

## Endpoints 

### Returns All Merchants

Request:
```
GET /api/v1/merchants
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body:
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        }
        ...
    ]
}
```
### Returns All Items

Request:
```
GET /api/v1/items
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body:
{
    "data": [
        {
            "id": "75",
            "type": "item",
            "attributes": {
                "name": "Shiny Itemy Item",
                "description": "It does a lot of things real good",
                "unit_price": 5011.0,
                "merchant_id": 43
            }
        },
        {
            "id": "601",
            "type": "item",
            "attributes": {
                "name": "Item Voluptates Ad",
                "description": "Possimus vero accusantium. Quia qui nulla repellat est. Vel eaque vitae soluta.",
                "unit_price": 598.67,
                "merchant_id": 30
            }
        }
        ...  
    ]
}
```
