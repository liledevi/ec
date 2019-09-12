class CartsController < ApplicationController
  def show
    cart = Cart.find_by(user_id: current_user.id)
    cart_products = CartProduct.where(cart_id: cart.id).includes(:product)
    @products_in_cart = []
    cart_products.each do |cart_product|
      @products_in_cart.push(cart_product.product)
    end
    @total_price = total_price
  end
  
  def create
    cart = current_user.cart
    product = Product.find(params[:product_id])
    if  cart.cart_products.create!(product_id: product.id)
      redirect_to root_path, success: '成功'
    else
      flash.now[:danger] = '失敗'
      render :show
    end
  end
  
  def destroy
    cart = current_user.cart || current_user.create_cart
    product = Product.find(params[:product_id])
    cart_product = cart.cart_products.find_by(product_id: product.id)
    if cart_product.destroy!
      redirect_to carts_show_path, success: '削除に成功'
    else
      flash.now[:danger] = '削除に失敗'
      render :show
    end
  end

  def total_price
    @products_in_cart.inject(0) { |sum, product|
    sum + product.price
    }
  end
end