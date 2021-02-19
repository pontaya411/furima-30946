class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  
  def index
    @item = Item.find(params[:item_id])
    @buyaddresses = BuyAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @buyaddresses = BuyAddress.new(buy_params)
    if @buyaddresses.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_params[:token],
        currency: 'jpy'
      )
      @buyaddresses.save
      return redirect_to root_path
    else
      render 'index'
    end
  end
  
  private
  def buy_params
    params.require(:buy_address).permit(:prefecture_id, :post_code, :city, :address_number, :building_name, :phone_number, :item_id, :user_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
  
end
