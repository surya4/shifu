defmodule Shifu.MixFile do
  use Mix.Project

  @source_url "https://github.com/surya4/shifu"
  @app_version System.get_env("APP_VERSION", "0.0.1")

  def project do
    [
      app: :shifu,
      version: @app_version,
      elixir: "~> 1.13.2",
      description: description(),
      source_url: @source_url,
      homepage_url: @source_url,
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      preferred_cli_env: preferred_cli_env(),
      # https://stackoverflow.com/a/44665998/7938045
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      aliases: aliases(),
      deps: deps(),
      docs: docs(),
      dialyzer: dialyzer()
    ]
  end

  def application do
    [
      mod: {Shifu.App, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Project dependencies.
  defp deps do
    [
      {:credo, "~> 1.6.2", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:ecto_sql, "3.7.1"},
      {:ecto_enum, "~> 1.4"},
      {:ex_machina, "~> 2.7", only: [:test]},
      {:excoveralls, "~> 0.14.4", only: :test},
      {:hackney, "~> 1.18"},
      {:jason, "~> 1.3"},
      {:phoenix, "~> 1.6.6"},
      {:plug_cowboy, "~> 2.5.2"},
      {:postgrex, "~> 0.15.13"},
      {:sentry, "~> 8.0"}
    ]
  end

  defp description do
    """
    Shifu is a an elixir boilerplate .
    """
  end

  defp docs do
    [
      main: "readme",
      name: "Shifu",
      source_ref: "v#{@app_version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end

  defp dialyzer do
    [
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
      plt_add_apps: [:mix, :ex_unit]
    ]
  end

  defp preferred_cli_env do
    [
      coveralls: :test,
      "coveralls.html": :test,
      "coveralls.json": :test
    ]
  end

  defp aliases do
    [
      compile_check: ["compile --warnings-as-errors --all-warnings"],
      credo: ["credo --strict"],
      format_check: ["format --check-formatted"],
      quality: ["credo", "format_check", "compile_check", "dialyzer"],
      sentry_recompile: ["compile", "deps.compile sentry --force"],
      start: ["phx.server"],
      test: ["ecto.create --quiet", "ecto.migrate", "test --trace --warnings-as-errors --raise"]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
