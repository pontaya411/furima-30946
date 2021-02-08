class ItemsController < ApplicationController
  # ログインしていないユーザーをログイン画面に促す記述
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  def index
    # 出品投稿の新しい順に表示できるようorderメソッド記述
    @items = Item.all.order(created_at: :desc)
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
  
  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end    
  end
  private

  def item_params
    params.require(:item).permit(:image, :name, :subscription, :status_id, :category_id, :price, :ship_fee_id, :ship_date_id,
                                 :prefecture_id).merge(user_id: current_user.id)
  end
end
