require 'net/http'
require 'json'
class ApiController < ApplicationController
    layout 'map', :only => [ :index, :show ]
    @@networks = ['https://api.citybik.es/v2/networks/bikesampa',
                  'https://api.citybik.es/v2/networks/ciclosampa']
    def index
        @lat_lng = nil;
    end
    def action
        if user_signed_in?
            @user = current_user
            @lat_lng = cookies[:lat_lng].split("|")
            @user.latitude = @lat_lng[0]
            @user.longitude = @lat_lng[1]
        end
    end

    # Action that returns a json with the station closer to the user with
    # free slots!
    def free_slots
        uPos = params[:pos]
        foundSt = false
        destStation = ""
        stationList = get_stationList(uPos)
        for station in stationList
            if station["empty_slots"] != 0
                destStation = station["name"]
                foundSt = true
                break
            end
        end
        response = {:success => foundSt, :destStation => destStation}
        respond_to do |format|
            format.json {render :json => response, status: 200}
        end
    end

    # Returns a list of stations ordered by the distance to 'uPos'
    def get_stationList(uPos)
        stationList = []
        for n in @@networks
            resp = Net::HTTP.get_response(URI.parse(n)).body
            result = JSON.parse(resp)['network']['stations']
            (stationList << result).flatten!
        end
        stationList.sort! {|s1, s2| dist_user(s1, uPos) <=> dist_user(s2, uPos)}
    end

    # Returns the distance between the point 'a' and 'b', using the haversine formula
    def dist_user(a, b)
        earth_R = 6371e3 #The earth radius, im meters!
        φ1 = (a["latitude"]).to_f * Math::PI / 180
        φ2 = (b["coords"]["latitude"]).to_f * Math::PI / 180
        Δφ = ((b["coords"]["latitude"]).to_f-(a["latitude"]).to_f)* Math::PI / 180
        Δλ = ((b["coords"]["longitude"]).to_f-(a["longitude"]).to_f)* Math::PI / 180
        a = Math.sin(Δφ/2)**2+Math.cos(φ1)*Math.cos(φ2)*Math.sin(Δλ/2)**2
        earth_R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    end

  def self.get_sampa_stations
    station_list = []
    for n in @@networks
      resp = Net::HTTP.get_response(URI.parse(n)).body
      result = JSON.parse(resp)['network']['stations']
      (station_list << result).flatten!
    end

    station_list.each do |s|
      puts s
    end
  end

end
