class WishesController < ApplicationController
  before_action :set_wish, only: [:show, :edit, :update, :destroy]

  def index
    @wishes = Wish.all.order(created_at: :desc)
  end

  def show
    @saving = Saving.new
  end

  def new
    @wish = Wish.new
  end

  def create
    @wish = Wish.new(wish_params)
    if @wish.save
      redirect_to wishes_path, notice: '欲しいものを登録しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @wish.update(wish_params)
      redirect_to wish_path(@wish), notice: '更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @wish.destroy
    redirect_to wishes_path, notice: '削除しました。'
  end

  private

  def set_wish
    @wish = Wish.find(params[:id])
  end

  def wish_params
  params.require(:wish).permit(:title, :target_amount, :deadline, :link_url, :memo, :image)
  end
end