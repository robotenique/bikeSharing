class OpenTimesController < ApplicationController
  before_action :set_open_time, only: [:show, :edit, :update, :destroy]

  # GET /open_times
  # GET /open_times.json
  def index
    @open_times = OpenTime.all
  end

  # GET /open_times/1
  # GET /open_times/1.json
  def show
  end

  # GET /open_times/new
  def new
    @open_time = OpenTime.new
  end

  # GET /open_times/1/edit
  def edit
  end

  # POST /open_times
  # POST /open_times.json
  def create
    @open_time = OpenTime.new(open_time_params)

    respond_to do |format|
      if @open_time.save
        format.html { redirect_to @open_time, notice: 'Open time was successfully created.' }
        format.json { render :show, status: :created, location: @open_time }
      else
        format.html { render :new }
        format.json { render json: @open_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /open_times/1
  # PATCH/PUT /open_times/1.json
  def update
    respond_to do |format|
      if @open_time.update(open_time_params)
        format.html { redirect_to @open_time, notice: 'Open time was successfully updated.' }
        format.json { render :show, status: :ok, location: @open_time }
      else
        format.html { render :edit }
        format.json { render json: @open_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /open_times/1
  # DELETE /open_times/1.json
  def destroy
    @open_time.destroy
    respond_to do |format|
      format.html { redirect_to open_times_url, notice: 'Open time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_time
      @open_time = OpenTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def open_time_params
      params.require(:open_time).permit(:open, :close, :dow, :station_id)
    end
end
