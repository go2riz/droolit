# Supported options: :resque, :sidekiq, :delayed_job, :queue_classic

Devise::Async.setup do |config|
  config.backend = :resque
  config.queue   = :mailing_queue
end