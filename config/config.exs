import Config

config :ex_aws,
  debug_requests: true,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: {:system, "AWS_REGION"}

config :directory_shifter,
  origin_bucket: "ORIGIN_BUCKET",
  destiny_bucket: "DESTINY_BUCKET"

import_config "#{Mix.env()}.exs"
