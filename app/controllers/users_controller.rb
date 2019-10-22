class UsersController < ApplicationController
  def show
    # params[:id]の部分は、たとえばユーザーidの1に置き換わる。
    @user = User.find(params[:id])
  end

  def new
  end
end
