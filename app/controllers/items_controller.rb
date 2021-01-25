class ItemsController < ApplicationController
  def index
  end

  private

  # imageという名前で送られできた画像ファイルの保存を許可する記述
  def item_params
    params.require(:item).permit(:image).merge(user_id: current_user.id)
    
  end
end
