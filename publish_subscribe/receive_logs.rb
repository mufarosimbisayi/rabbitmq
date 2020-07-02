#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
exchange = channel.fanout('logs')
queue = channel.queue('', exclusive: true)

queue.bind(exchange)

puts ' [*] Waiting for messages. To exit press CTRL+C'

begin
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
    puts " [x] '#{body}'"
  end
rescue Interrupt => _
  connection.close
end
