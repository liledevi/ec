class ChargesController < ApplicationController
  protect_from_forgery except: :create
  
  def create
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    token = params[:stripeToken]
    product_ids = params[:product_ids].map(&:to_i)
    # products = current_user.cart.cart_products.where(id: product_ids)
    # products = Product.where(id: product_ids)
    
    total_price = 0
    current_user.cart.cart_products.each do |cart_product|
      product = Product.find_by(id: cart_product.product_id)
      total_price = total_price + product.price
    end
    # puts("+++++++++++", total_price)
    # total_price = products.sum(:price)
    
    Stripe::Charge.create({
      amount: total_price,
      currency: 'jpy',
      description: 'Example charge',
      source: token
    })
    
    product_ids.each do |product_id|
      PurchaseHistory.create(user_id: current_user.id, product_id: product_id)
    end
    
    cart_products = current_user.cart.cart_products.where(product_id: product_ids)
    cart_products.each(&:destroy!)

    redirect_to root_path, notice: '決済に成功しました'
  end
  
end
