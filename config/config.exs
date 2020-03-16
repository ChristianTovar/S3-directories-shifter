import Config

config :cloudinex,
  debug: false,
  base_url: "base-url",
  api_key: "api-key",
  secret: "secret",
  cloud_name: "cloud-name"

config :ex_aws,
  debug_requests: true,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: {:system, "AWS_REGION"}

import_config "#{Mix.env()}.exs"
