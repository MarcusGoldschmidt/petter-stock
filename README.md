# petter-stock

Learn with simple stock

My cousin asked me to help her with expiry dates
of her products, so I decided to work in this project for fun.

Excel possibly solve this problem, but I want an excuse to learn new things.
## Goals

- [x] Jwt
- [ ] Basic crud operations
- [ ] Real time enter and exit products with barcode
- [ ] Dashboard
- [ ] Notifications about product validity
- [ ] Multi tenants
- [ ] Google login
- [ ] Docker files
- [ ] CI/CD
## Stack

- Elixir (Phoenix Framework)
- Postgres
- React

Just for learning functional programing in web apps

## How to setup

```sh
# in project root
docker-compose up

# in stock_api folder
mix ecto.migrate
mix phx.server # http://localhost:4000

# in stock_front folder
npm run start # http://localhost:3000
```