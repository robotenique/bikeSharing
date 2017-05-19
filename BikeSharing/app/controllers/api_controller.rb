class ApiController < ApplicationController
  def index
      @location = {:lat => -23.5505, :lon => -46.6333}.to_json
  end

end
