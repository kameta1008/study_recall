class RecallsController < ApplicationController
  def complete
    @recall = Recall.find(params[:id])
    if @recall.update(completed: true)
      flash[:notice] = "復習が完了しました！次の復習日が設定されました。"
    else
      flash[:alert] = "復習完了に失敗しました。"
    end
    redirect_to root_path
  end
end