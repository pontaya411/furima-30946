class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :contributor_confirmation, only: [:index, :create]

  def index
    @buyaddresses = BuyAddress.new
  end

  def create
    @buyaddresses = BuyAddress.new(buy_params)
    if @buyaddresses.valid?
      pay_item
      @buyaddresses.save
      redirect_to root_path
    else
      render 'index'
    end

  end

  private

  def buy_params
    params.require(:buy_address).permit(:prefecture_id, :post_code, :city, :address_number, :building_name, :phone_number, :item_id, :user_id).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_params[:token],
        currency: 'jpy'
      )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def contributor_confirmation
    if current_user.id == @item.user.id || @item.buy.present?
      redirect_to root_path
    end  
  end
end
