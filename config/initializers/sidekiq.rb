Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'chiefstats' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'chiefstats' }
end
