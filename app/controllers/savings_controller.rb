class SavingsController < ApplicationController
  def create
    @wish = Wish.find(params[:wish_id])
    @saving = @wish.savings.build(saving_params)
    @saving.saved_at ||= Time.current

    if @saving.save
      redirect_to wish_path(@wish), notice: '貯金を記録しました！'
    else
      redirect_to wish_path(@wish), alert: '金額を入力してください。'
    end
  end

  private

  def saving_params
    params.require(:saving).permit(:amount, :saved_at, :memo)
  end
end
