#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
exchange = channel.fanout('logs')

message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

exchange.publish(message, persistent: true)
puts " [x] Sent #{message}"

connection.close
