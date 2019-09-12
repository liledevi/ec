class Admins::ProductsController < Admins::ApplicationController
  
  def new
   @product = current_admin.products.build
  end
  
  def create
    @product = current_admin.products.build(product_params)
    if @product.save
      redirect_to root_path, success: '作成に成功'
    else
      flash.now[:danger] = '作成に失敗'
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end

