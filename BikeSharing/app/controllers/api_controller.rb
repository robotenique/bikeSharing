class ApiController < ApplicationController
    layout 'map', :only => [ :index, :show ]
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

end
