require 'rufus-scheduler'

scheduler2 = Rufus::Scheduler.new

scheduler2.every '5m' do
  StationHistoryMaintainer.fetch_and_insert
end