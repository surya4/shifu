import Config

config :shifu,
  ecto_repos: [Shifu.Repo]

config :shifu, ShifuWeb.Endpoint,
  server: true,
  render_errors: [accepts: ~w(json), layout: false],
  debug_errors: false,
  code_reloader: false

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
