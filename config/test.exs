import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :health_tracker, HealthTracker.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "health_tracker_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  sql_sandbox: true

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :health_tracker, HealthTrackerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "P5GVPJkRc0knamQZe98f1zf7zUR9zmhTxqoFqB1Wk7WVB+To3VwlHLGMZAQQVXpX",
  # server: false # Changed to true when adding Wallaby
  server: true

# In test we don't send emails.
config :health_tracker, HealthTracker.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :wallaby, driver: Wallaby.Chrome
