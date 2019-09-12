class Admins::DashboardsController < Admins::ApplicationController
  def index
    @purchase_histories = PurchaseHistory.all
    
    this_month_cond = { created_at: Time.now.all_month }
    @month_purchase_histories = PurchaseHistory.all.where(this_month_cond)
  end
  
  def all
    product_table = Product.arel_table
    purchase_history_table = PurchaseHistory.arel_table
    hoge = purchase_history_table[:product_id].eq(product_table[:id])
    
    product_cond = PurchaseHistory.where(hoge).exists
    @products = Product
                  .where(product_cond)
                  .order(id: "DESC")
  end
  
  def month
    this_month_cond = { created_at: Time.now.all_month }
    product_cond = { purchase_histories: this_month_cond }
    @month_products = Product
                        .eager_load(:purchase_histories)
                        .where(product_cond)
                        .order(id: "DESC")
  end
  
end
