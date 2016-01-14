# PULSE APP

## Set up database

```sql

sudo su - postgres
psql -c "create user pulse with password 'pulse' CREATEDB"
exit
```

```ruby
rake db:create
```

## Tests

run your tests with `rspec`

## Run Server

rails s