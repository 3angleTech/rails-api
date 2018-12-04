# railsApi

Web API stub project written in Ruby using [RubyOnRails](https://rubyonrails.org/)

## Prerequisites

[RVM](https://rvm.io/rvm/install), a command-line tool which allows you to easily install, manage, and work with multiple ruby environments from interpreters to sets of gems.

Docker v17.0 & Docker Compose - installation instructions can be found [here](https://docs.docker.com/install/) or [here](https://docs.docker.com/compose/install/).

The recommended IDE is [Visual Studio Code](https://code.visualstudio.com/).

## Running the application


### Prepare environment

The application requires a PostgreSql instance which is available via docker when running.
```
$ docker-compose up -d 3at-railsapi-postgres
```
If you use docker on test or production environment update Docker file to set specific environment variables
```
ENV POSTGRES_DB=threeangle_development
ENV POSTGRES_USER=threeangle
#ENV POSTGRES_PASSWORD=
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


## Models, migrations, seed script, rake cron jobs

### Adding a model
The command below will generate the file for table creation. Choose a comprehensible name for table creation operation (will be a class in the generated file).
```
rails generate migration CreateUsers
```
Open the newly created file and add columns to the table creation script (see [documentation](https://api.rubyonrails.org/classes/ActiveRecord/Migration.html)). Then run migration for the specific environment:
```
rails db:migrate RAILS_ENV=development
```
If something goes wrong you can rollback migrations. See bellow rollback-ing one step.
```
$ rake db:rollback STEP=1
```
Create the class for the model in `app/models`. Example:
```
class Movie < ApplicationRecord
  # validations
  validates_presence_of :release_date
end
```


### Generate migration
Choose a comprehensible name to migration name. The command below will generate a file in `/db/migrate` with the chosen name as class name.
```
rails generate migration AddXColumnToYTable
```
Add migration instructions (see [documentation](https://api.rubyonrails.org/classes/ActiveRecord/Migration.html)), then run migration for specific environment
```
rails db:migrate RAILS_ENV=development
```
If something goes wrong you can rollback migrations. See bellow rollback-ing one step.
```
$ rake db:rollback STEP=1
```

### Create a seed script
Create a file in `db/seeds` folder with the `<seed_number>_<table_to_be_filled>.rb` name format. 
This file should contain all the record creation needed to seed the database with its default values. Example:
```
movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
Character.create(name: 'Luke', movie: movies.first)
```
The data can then will be loaded with the following command:
```
$ rails db:seed
```

### Rake task w/ cron jobs
Create a new rake task file in `lib/tasks` (see `job_example.rake` as template).
Run the task with the following command (rake namespace:job_name)
```
rake threeangle:sample_job
```
Configure cron to run the rake job:
```
crontab -e
```
Add the cron entry for your job
```
0 0 * * * cd /path/to/railsapp && /usr/local/bin/rake RAILS_ENV=production threeangle:sample_job
```
To find the full path for your rake executable, run:
```
which rake
```
