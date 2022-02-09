import Config

environment = config_env()
db_max_pool_size = System.get_env("DATABASE_POOL_MAX", "8") |> Integer.parse()
log_level = System.get_env("LOG_LEVEL", "info") |> String.to_existing_atom()
base_url = System.get_env("API_BASE_URL", "http://localhost:8000")
base_url = URI.parse(base_url)

sentry_dsn = System.get_env("SENTRY_DSN")
storage_upload_path = System.get_env("STORAGE_PATH")

config :shifu,
  env: environment

if environment == :dev do
  config :shifu, ShifuWeb.Endpoint,
    debug_errors: true,
    code_reloader: true
end

config :shifu, ShifuWeb.Endpoint,
  http: [port: base_url.port, transport_options: [max_connections: :infinity]]

# Configure database
config :shifu, Shifu.Repo,
  username: System.get_env("DATABASE_USERNAME", "postgres"),
  password: System.get_env("DATABASE_PASSWORD", "password"),
  database: System.get_env("DATABASE_NAME", "shifu"),
  hostname: System.get_env("DATABASE_HOST", "localhost"),
  port: System.get_env("DATABASE_PORT", "5432"),
  show_sensitive_data_on_connection_error: true,
  pool_size: db_max_pool_size,
  parameters: [
    application_name: System.get_env("DATABASE_APPLICATION_NAME", "shifu")
  ]

# Uploads related configs
config :shifu,
  storage_upload_path: storage_upload_path

config :logger,
  backends: [:console, Sentry.LoggerBackend]

config :sentry,
  dsn: sentry_dsn,
  environment_name: environment,
  included_environments: [:prod],
  enable_source_code_context: true,
  root_source_code_path: [File.cwd!()]

config :logger, :console,
  level: log_level,
  format: "$date $time $level $metadata $message\n",
  compile_time_purge_level: :info,
  metadata: [:request_id]

config :logger, Sentry.LoggerBackend,
  capture_log_messages: true,
  level: :error

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
if environment in [:dev, :test] do
  config :phoenix, :stacktrace_depth, 20
  config :shifu, Shifu.Repo, pool_size: 1
end

if environment == :test do
  config :shifu, Shifu.Repo, pool: Ecto.Adapters.SQL.Sandbox
  config :logger, :console, level: :warn
end
