require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '120m' do
  StationHistoryMaintainer.fetch_and_insert
end
