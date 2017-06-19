require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '5m' do
  StationHistoryMaintainer.fetch_and_insert
end