class UsersController < ApplicationController
  def show
    @user = current_user
  end
  
  def mypage
    @user = current_user
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    if current_user.update(user_params)
      falsh[:notice] = "更新しました"
      redirect_to users_show_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :introduction,
      :image
    )
  end
end
