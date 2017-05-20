class ApiController < ApplicationController
  layout 'map', :only => [ :index, :show ]
  def index
  end

end
