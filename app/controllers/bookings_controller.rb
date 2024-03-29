class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @room = Room.find(params[:room_id])
    @bookings = @room.bookings.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    room_id = @booking.room_id
    @room = Room.find(room_id)
  end

  # GET /bookings/new
  def new
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.new
  end

  # GET /bookings/1/edit
  def edit; end

  # POST /bookings
  # POST /bookings.json
  def create
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to user_room_url(current_user, @room), notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to user_room_url(current_user, @room), notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @room = Room.find(@booking.room_id)
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to user_room_url(current_user, @room), notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
