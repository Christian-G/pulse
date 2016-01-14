# PULSE APP

## Set up database

```sql
sudo su - postgres
psql -c "create user pulse with password 'pulse' CREATEDB"
try this command if asked for a password
createuser -P -S -d -R -l -e pulse
exit
```

```ruby
bundle install
rake db:create
```

## Tests

run your tests with `rspec`

## Run Server

rails server