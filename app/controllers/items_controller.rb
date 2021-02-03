class ItemsController < ApplicationController
  # ログインしていないユーザーをログイン画面に促す記述
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @items = Item.all
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

  def item_params
    params.require(:item).permit(:image, :name, :subscription, :status_id, :category_id, :price, :ship_fee_id, :ship_date_id,
                                 :prefecture_id).merge(user_id: current_user.id)
  end
end
