class StationHistoriesController < ApplicationController
  before_action :set_station_history, only: [:show, :edit, :update, :destroy]

  # GET /station_histories
  # GET /station_histories.json
  def index
    @station_histories = StationHistory.all
  end

  # GET /station_histories/1
  # GET /station_histories/1.json
  def show
  end

  # GET /station_histories/new
  def new
    @station_history = StationHistory.new
  end

  # GET /station_histories/1/edit
  def edit
  end

  # POST /station_histories
  # POST /station_histories.json
  def create
    @station_history = StationHistory.new(station_history_params)

    respond_to do |format|
      if @station_history.save
        format.html { redirect_to @station_history, notice: 'Station history was successfully created.' }
        format.json { render :show, status: :created, location: @station_history }
      else
        format.html { render :new }
        format.json { render json: @station_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /station_histories/1
  # PATCH/PUT /station_histories/1.json
  def update
    respond_to do |format|
      if @station_history.update(station_history_params)
        format.html { redirect_to @station_history, notice: 'Station history was successfully updated.' }
        format.json { render :show, status: :ok, location: @station_history }
      else
        format.html { render :edit }
        format.json { render json: @station_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /station_histories/1
  # DELETE /station_histories/1.json
  def destroy
    @station_history.destroy
    respond_to do |format|
      format.html { redirect_to station_histories_url, notice: 'Station history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station_history
      @station_history = StationHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_history_params
      params.require(:station_history).permit(:free_slots, :free_bikes, :rate)
    end
end
