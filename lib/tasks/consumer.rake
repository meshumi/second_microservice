namespace :consumer do
  desc 'Start message consumer'
  task start: :environment do
    MessageConsumer.new.process_messages
  end
end