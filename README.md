# railsApi

Web API stub project written in Ruby using [RubyOnRails](https://rubyonrails.org/)

## Prerequisites

[RVM](https://rvm.io/rvm/install), a command-line tool which allows you to easily install, manage, and work with multiple ruby environments from interpreters to sets of gems.

Docker v17.0 & Docker Compose - installation instructions can be found [here](https://docs.docker.com/install/) or [here](https://docs.docker.com/compose/install/).

The recommended IDE is [Visual Studio Code](https://code.visualstudio.com/).

## Running the application


### Prepare environment

The application requires a PostgreSql instance which is available via docker when running

```
$ docker-compose up -d 3at-postgres
```

We need to move to the `railsApi` folder in a terminal and run initially

```
$ rvm install 2.5.0
$ rvm use 2.5.0 --default
$ gem install bundler
```

Some gems need other libraries to be built
- Ubuntu dependencies install
```
$ sudo apt-get install build-essential libpq-dev
```

### Running the application via RVM

Install dependencies

```
$ bundle install
```
initialize database schema (replace `development` with specific environment)
```
$ rails db:migrate RAILS_ENV=development
```
add default entries in tables
```
$ rake db:seed
```

and afterwards to start the Rails server
- development server
```
$ rails s
```
- test/production server
```
$ bundle exec rails s -d -p 3000 -b '0.0.0.0'
```

Test the server
```
curl http://localhost:3000/api/v1/health-check
```


## Adding 

### Generate migration

Choose a comprehensible name to migration name. The command below will generate a file in `/db/migrate` with the chosen name.
```
cd db/migrate/
rails generate migration AddXColumnToYTable
```
Add migration instructions (see [documentation](https://api.rubyonrails.org/classes/ActiveRecord/Migration.html)), then run migration for specific environment
```
rails db:migrate RAILS_ENV=development
```
If something wrong you can rollback migrations. See bellow rollback-ing one step.
```
$ rake db:rollback STEP=1
```