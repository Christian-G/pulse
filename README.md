# PULSE APP

## Set up database

```sql

psql -h localhost postgres -c "create user pulse with password 'pulse' CREATEDB"
```

```ruby
rake db:create
```

## Tests

run your tests with `rspec`

## Run Server

rails s