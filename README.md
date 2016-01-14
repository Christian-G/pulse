# PULSE APP

## Set up database

Make sure Postgres listens to localhost

```sql
sudo su - postgres
psql -c "create user pulse with password 'pulse' CREATEDB"
```
try this command if asked for a password
exit


```ruby
bundle install
rake db:create
```

## Tests

run your tests with `rspec`

## Run Server

rails server