class RoomsController < ApplicationController
  before_action :search
  def index
    @rooms = current_user.rooms #ログインしてるユーザーの登録施設のみ表示
    @user = current_user
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_own_path
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @q = Room.ransack
    @user = current_user
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room.id)
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  def search
    # params[:q]のqには検索フォームに入力した値が入る
    @q = Room.ransack(params[:q])
    # distinct: trueは重複したデータを除外
    @rooms = @q.result(distinct: true)
  end

  private

  def room_params
    params
    .require(:room)
    .permit(
      :name,
      :overview,
      :price,
      :address,
      :roomimage,
      :user_id
    )
    .merge(user_id: current_user.id)
  end
end
