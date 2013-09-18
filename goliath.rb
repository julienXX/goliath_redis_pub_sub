require 'bundler'
Bundler.require

class Subscribe < Goliath::API

  def response(env)
    @redis = EM::Hiredis.connect
    pubsub = @redis.pubsub
    channel = "events"
    pubsub.subscribe channel

    env.logger.info "Starting"
    env.logger.info "Subscribing to #{channel}"

    pubsub.on(:message) { |channel, message|
      env.stream_send(payload(message))
    }

    streaming_response(200, {'Content-Type' => 'text/event-stream', 'Cache-Control' => 'no-cache', 'Connection' => 'keep-alive'})
  end

  def on_close(env)
    env.logger.info "Disconnect."
    @redis.disconnect
  end

  def payload(message)
    { id: Time.now.to_i, data: message }.to_json + "\n"
  end

end
