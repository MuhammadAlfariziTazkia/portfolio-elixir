import Config

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  ip_host = System.get_env("PHX_HOST") || "202.10.42.156"  # Ganti sesuai IP VPS kamu
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :portfolio, PortfolioWeb.Endpoint,
    url: [host: ip_host, port: port],
    http: [ip: {0, 0, 0, 0}, port: port],
    secret_key_base: secret_key_base,
    check_origin: ["//#{ip_host}"]

  database_url =
    System.get_env("DATABASE_URL") ||
      raise "environment variable DATABASE_URL is missing."

  config :portfolio, Portfolio.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    ssl: false  # Jika PostgreSQL di localhost tanpa SSL, ubah jadi false
end
