class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @accessories = @cart.format
  end

  def create
    if current_user && @cart.total_count != 0
      order = current_user.orders.create!(total: @cart.contents.values.sum, status: "Ordered", user_id: current_user.id)
      flash[:order] = "You have successfully submitted your order totaling $#{@cart.cart_total}!"
      # session.delete(:cart)
      redirect_to dashboard_path
    elsif current_user && @cart.total_count == 0
      flash[:notice] = "Your cart is empty, please add items from the #{view_context.link_to 'bike shop', bike_shop_path} to your cart first before checking out!"
      redirect_to carts_path
    else 
      redirect_to login_path
      flash[:alert] = 'Please login before checking out!'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to order_path(order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
