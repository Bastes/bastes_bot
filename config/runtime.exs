import Config

if Config.config_env() == :dev do
  DotenvParser.load_file(".env")
end

config :nostrum, token: System.get_env("BOT_TOKEN")

config :bastes_bot,
  env: Config.config_env(),
  dev_guild_id: System.get_env("DEV_GUILD_ID")
