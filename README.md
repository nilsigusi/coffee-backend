# Simple Coffee Counter - backend server

This is a RAILS-5 backend API for the coffee counter.

Its a usual RESTfull API using `JWT` for authentication.

## Install

[see this instructions](doc/INSTALL.md)

## development

its good to use a docker container with rails.

in development mode do:

```bash
bundle install --without production
rails db:setup RAILS_ENV=development
rails server -b 0.0.0.0
```

this would use e.g sqlite database

# License

GNU GPL v3 or newer,
Copyright (c) 2015 to Dmitry Nilsen
