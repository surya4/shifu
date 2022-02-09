# Shifu

![](https://github.com/surya4/shifu/workflows/Backend%20Code%20Quality/badge.svg) ![](https://github.com/surya4/shifu/workflows/Backend%20Automated%20Tests/badge.svg)

## Introduction

Shifu: Elixir Boilerplate with Postgres

## Dependencies

```bash
  Elixir v1.13.2
  Phoenix 1.6.6
  Erlang/OTP 24
```

## Installation

### Envrionment Variables

```bash
export API_BASE_URL="http://localhost:8000"

# Module configs
export STORAGE_PATH="/tmp"

# Database / PostgresDB configs
export DATABASE_HOST="127.0.0.1"
export DATABASE_USERNAME="admin"
export DATABASE_PASSWORD="admin"
export DATABASE_PORT="5432"
export DATABASE_NAME="shifu"
export DATABASE_APPLICATION_NAME="shifu"
export DATABASE_POOL_MAX="1"

# Log level
export LOG_LEVEL="info"

# sentryDSN
export SENTRY_DSN="xxx"
```

### Setup / Run

```bash
git clone https://github.com/surya4/shifu shifu
cd shifu
mix deps.get
mix start
```

### Code Testing

```bash
mix deps.get
mix test
```

### Check code coverage

```bash
mix coveralls
```

### Code linting

```bash
mix credo
```

### Check code formatting

```bash
mix format --check-formatted
```

### Compilation errors

```bash
mix compile --warnings-as-errors --all-warnings
```

### Static code analyzer

```bash
mix dialyzer
```

### Fix code formatting

```bash
mix format
```
