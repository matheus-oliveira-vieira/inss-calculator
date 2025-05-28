
# INSS Calculator

  
A scalable RESTful API for for calculate INSS discounts built with Ruby on Rails, following iterative development principles.


## Features


### Core Functionality

-  **Proponent CRUD** with all the necessary fields

-  **INSS discount calculation** for different salary ranges

-  **Proponent dashboard** grouped by salary ranges

-  **RSpec test coverage** (models, requests, services)

  

## Technical Stack

-  **Framework:** Rails 8.0.2

-  **Database:** PostgreSQL

-  **Testing:** RSpec + FactoryBot

  

## Installation

```bash
git  clone  git@github.com:matheus-oliveira-vieira/inss-calculator.git

cd  inss-calculator

bin/setup
```

## Fill Database
Run the command below to fill database with 10 proponents

```bash
rails dev:seeds
```

## Test
Run the command below to execute all tests

```bash
rspec
```

## How to run the Application
In a terminal, run the following command to run the application.

```bash
bin/dev
```

To access the initial page, use the following credentials

```bash
email: admin@inss.com
password: admin123
```

## License

MIT. Use and adapt freely!