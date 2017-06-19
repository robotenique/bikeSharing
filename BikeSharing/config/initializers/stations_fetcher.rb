require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  UpdateLocalStations.update
end