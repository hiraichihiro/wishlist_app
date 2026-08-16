class WishesController < ApplicationController
  before_action :set_wish, only: [:show, :edit, :update, :destroy, :toggle_fulfill]

  # 未達成リスト一覧
  def index
    @wishes = Wish.where(fulfilled: [false, nil]).order(created_at: :desc)
  end

  # 🏆 達成済みリスト一覧
  def fulfilled
    @fulfilled_wishes = Wish.where(fulfilled: true).order(updated_at: :desc)
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

  # 達成切り替え
  def toggle_fulfill
    @wish.update(fulfilled: !@wish.fulfilled)
    if @wish.fulfilled
      redirect_to fulfilled_wishes_path, notice: "🎉 『#{@wish.title}』を達成しました！コレクションに追加されました✨"
    else
      redirect_to wishes_path, notice: "『#{@wish.title}』を未達成リストに戻しました。"
    end
  end

  private

  def set_wish
    @wish = Wish.find(params[:id])
  end

  def wish_params
    params.require(:wish).permit(:title, :target_amount, :deadline, :link_url, :memo, :image, :fulfilled)
  end
end