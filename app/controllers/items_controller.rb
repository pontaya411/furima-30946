class ItemsController < ApplicationController
  # ログインしていないユーザーをログイン画面に促す記述
  before_action :authenticate_user!, only: [:new, :create]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  # imageという名前で送られできた画像ファイルの保存を許可する記述
  def item_params
    params.require(:item).permit(:image).merge(user_id: current_user.id)
    
  end
end
