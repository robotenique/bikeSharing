class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]

  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.all
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
  end

  # GET /stations/new
  def new
    @station = Station.new
  end

  # GET /stations/1/edit
  def edit
    # Dealing with position
    @station.latitude  = @station.position.lat
    @station.longitude = @station.position.long
    # Dealt
  end

  # POST /stations
  # POST /stations.json
  def create
    @station = Station.new(station_params)

    # Dealing with position
    position = Position.new
    position.lat  = @station.latitude
    position.long = @station.longitude
    @station.position = position
    # Dealt

    respond_to do |format|
      if @station.save
        format.html { redirect_to @station, notice: 'Station was successfully created.' }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    respond_to do |format|
      if @station.update(station_params)
        # Dealing with position
        @station.position.update_attributes!(lat: @station.latitude, long: @station.longitude)
        # Dealt
        format.html { redirect_to @station, notice: 'Station was successfully updated.' }
        format.json { render :show, status: :ok, location: @station }
      else
        format.html { render :edit }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station.destroy
    respond_to do |format|
      format.html { redirect_to stations_url, notice: 'Station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      # :latitude and :longitude have been added in order to grant access to these vars when
      # passing through json from one view to another inside @station var
      params.require(:station).permit(:name, :free_slots, :free_bikes, :company, :latitude, :longitude)
    end
end
