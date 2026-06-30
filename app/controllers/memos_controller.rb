class MemosController < ApplicationController

  def create
    @memo = Memo.create!(memo_params)
    @memos = @memo.referrent && @memo.referrent.memos.order(created_at: :desc) || []
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("memo-feed", partial: "/memos/feed", locals: { 
          memo: Memo.new(kind: @memo.kind, referrent_id: @memo.referrent_id),
          memos: @memos
        })
      end
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:text, :kind, :referrent_id)
  end

end
