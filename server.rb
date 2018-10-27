require 'sinatra/base'
require 'json'
require 'bunny'
require 'dotenv'

Dotenv.load '../.env'

CONNECTION = Bunny.new
CONNECTION.start
CHANNEL = CONNECTION.create_channel
QUEUE = CHANNEL.queue(ENV['QUEUE'])

module CubeREST
  class App < Sinatra::Base

    patch '/lights' do
      data = JSON.parse request.body.read
      CHANNEL.default_exchange.publish({data: data['layers']}.to_json, routing_key: QUEUE.name)
    end
  end
end
