import Config

config :cloudinex,
  debug: false,
  base_url: "base-url",
  api_key: "api-key",
  secret: "secret",
  cloud_name: "cloud-name"

import_config "#{Mix.env()}.exs"
