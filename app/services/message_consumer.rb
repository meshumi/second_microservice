# app/services/message_consumer.rb
class MessageConsumer
  def initialize
    @connection = Bunny.new(hostname: 'localhost')
    @connection.start
    @channel = @connection.create_channel
    @queue = @channel.queue('my_queue')
  end

  def process_messages
    puts 'start process'
    @queue.subscribe(block: true) do |delivery_info, properties, body|
      # Зберігаємо повідомлення до бази даних
      message = Message.create(content: body)

      # Залоговуємо повідомлення
      puts "created message #{message.id}  and we have messages count = #{Message.count}"
      puts "Received message: #{body}"
      Rails.logger.info "Received message: #{body}"
    end
  end
end
