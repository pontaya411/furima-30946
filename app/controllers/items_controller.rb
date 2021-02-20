class ItemsController < ApplicationController
  # ログインしていないユーザーをログイン画面に促す記述
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
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
    # 下記にまとめてset_itemで記述
  end

  def edit
    # 下記にまとめてset_itemで記述
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :subscription, :status_id, :category_id, :price, :ship_fee_id, :ship_date_id,
                                 :prefecture_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path if current_user.id != @item.user.id || @item.buy.present?
  end
end
