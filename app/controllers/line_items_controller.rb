class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[ show edit update destroy ]

  # GET /line_items or /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1 or /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  def current_cart
    if session[:cart_id]
      Cart.find(session[:cart_id])
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end
  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items or /line_items.json
  # def create
  #   @line_item = LineItem.new(line_item_params)
  #
  #   respond_to do |format|
  #     if @line_item.save
  #       format.html { redirect_to line_item_url(@line_item), notice: "Line item was successfully created." }
  #       format.json { render :show, status: :created, location: @line_item }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @line_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    if params[:cart_id]
      @cart = Cart.find(params[:cart_id])
    else
      @cart = current_cart
    end

    @line_item = @cart.line_items.build(line_item_params)
    @product = Product.find(line_item_params[:product_id])
    @line_item.price = @product.price
    @line_item.product = @product

    if @line_item.save
      redirect_to @cart, notice: 'Line item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to line_items_path, notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }

      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    session[:cart_id] = nil
    redirect_to cart_path(@cart), notice: 'Line item was successfully removed from cart.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id, :quantity, :price)
    end
end
