require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.in '10s' do
  UpdateLocalStations.update
end