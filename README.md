# PULSE APP

## Set up database

```sql

psql -h localhost postgres -c "create user pulse with password 'pulse' CREATEDB"
```

```ruby
rake db:create
```

