class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @reservations = Reservation.where(user_id: current_user.id).includes(:user).order("created_at DESC")
  end

  def new
    @user = current_user
    @reservation = Reservation.new
    @room = Room.find(params[:room_id])
  end

  def create
    @user = current_user
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])

    if @reservation.save
      flash[:notice] = "予約に成功しました"
      redirect_to reservations_path (@reservation)
    else
      flash.now[:alert] = "予約に失敗しました"
      render "rooms/show"
    end
  end

  def edit
    @rooms = Room.all
    @reservation = Reservation.find(params[:id])
  end

  def update
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "削除しました"
    redirect_to reservations_path
  end
  
  def confirm
    @user = current_user
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :checkin_date,
      :checkout_date,
      :person_count,
      :total_price,
      :total_date,
      :user_id,
      :room_id,
      :created_at
    )
  end
end
