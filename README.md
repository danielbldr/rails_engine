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
### Returns One Merchant

Request:
```
GET /api/v1/merchants/1
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
        }
    }
}
```

### Returns One Item

Request:
```
GET /api/v1/items/75
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
        }
    }
}
```

### Creates A Merchant

Request:
```
POST /api/v1/merchants
Content-Type: application/json
Accept: application/json

Params should follow this pattern: 

{
  "name": "Daniel's Vegan Bakery",
}

```
Response:
```
status: 200
body:
{
    "data": {
        "id": "175",
        "type": "merchant",
        "attributes": {
            "name": "Daniel's Vegan Bakery"
        }
    }
}
```

### Creates An Item

Request:
```
POST /api/v1/items
Content-Type: application/json
Accept: application/json

Params should follow this pattern: 

{
  "name": "Vegan Almond Croissant",
  "description": "Warm Flaky Goodness",
  "unit_price": 4.50,
  "merchant_id": 175
}

```
Response:
```
status: 200
body:
{
    "data": {
        "id": "2558",
        "type": "item",
        "attributes": {
            "name": "Vegan Almond Croissant",
            "description": "Warm Flaky Goodness",
            "unit_price": 4.5,
            "merchant_id": 175
        }
    }
}
```

### Updates A Merchant

Request:
```
PUT /api/v1/merchants/75
Content-Type: application/json
Accept: application/json

Params should follow this pattern: 

{
  "name": "New Merchant",
}

```
Response:
```
status: 200
body:
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "New Merchant"
        }
    }
}
```

### Updates An Item

Request:
```
PUT /api/v1/item/75
Content-Type: application/json
Accept: application/json

Params should follow this pattern: 

{
  "name": "Purple Item",
}

```
Response:
```
status: 200
body:
{
    "data": {
        "id": "75",
        "type": "item",
        "attributes": {
            "name": "Purple Item",
            "description": "It does a lot of things real good",
            "unit_price": 5011.0,
            "merchant_id": 43
        }
    }
}
```

### Destroy A Record

Request:
```
DELETE /api/v1/item/75
Content-Type: application/json
Accept: application/json

Params should follow this pattern: 

{
  "name": "Purple Item",
}

```
Response:
```
status: 200
body:
{
    "data": {
        "id": "75",
        "type": "item",
        "attributes": {
            "name": "Purple Item",
            "description": "It does a lot of things real good",
            "unit_price": 5011.0,
            "merchant_id": 43
        }
    }
}
```

### Return All Items Associated With A Merchant

Request:
```
GET /api/v1/merchants/1/items
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",",
                "description": "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum.
                "unit_price": 751.07,
                "merchant_id": 1
            }
        }
        ...
    }
}
```

### Return The Merchant Associated With An Item

Request:
```
GET /api/v1/items/1/merchant
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "New Merchant"
        }
    }
}
```

### Can Find A Merchant Or An Item Based Off One Or More Criteria

Items can be searched by their attributes: name, description, unit_price, merchant_id, created_at, updated_at
Merchants can be searched by their attributs: name, created_at, updated_at

Request:
```
GET /api/v1/items/find?name=vegan&description=flaky
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body
{
    "data": {
        "id": "2558",
        "type": "item",
        "attributes": {
            "name": "Vegan Almond Croissant",
            "description": "Warm Flaky Goodness",
            "unit_price": 4.5,
            "merchant_id": 175
        }
    }
}
```

### Can Find Merchant(s) With Most Revenue

You can search for top n number of merchants 

Request:
```
GET /api/v1/merchants/most_revenue?quantity=2
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body
{
    "data": [
        {
            "id": "89",
            "type": "merchant",
            "attributes": {
                "name": "Kassulke, O'Hara and Quitzon"
            }
        },
        {
            "id": "14",
            "type": "merchant",
            "attributes": {
                "name": "Dicki-Bednar"
            }
        }
    ]
}
```

### Can Find Merchant(s) With Most Items Sold

You can search for top n number of merchants 

Request:
```
GET /api/v1/merchants/most_items?quantity=2
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body
{
    "data": [
        {
            "id": "89",
            "type": "merchant",
            "attributes": {
                "name": "Kassulke, O'Hara and Quitzon"
            }
        },
        {
            "id": "74",
            "type": "merchant",
            "attributes": {
                "name": "Daugherty Group"
            }
        }
    ]
}
```

### Can Search Revenue Across Date Range

Request:
```
GET /api/v1/revenue?start=2012-03-09&end=2012-03-24
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body
{
    "data": {
        "id": null,
        "type": "revenue",
        "attributes": {
            "revenue": 43194040.040000275
        }
    }
}
```

### Can Find Total Revenue Of A Merchant

Request:
```
GET /api/v1/merchants/1/revenue
Content-Type: application/json
Accept: application/json
```
Response:
```
status: 200
body
{
    "data": {
        "id": null,
        "type": "revenue",
        "attributes": {
            "revenue": 31702888.5600019
        }
    }
}
```
