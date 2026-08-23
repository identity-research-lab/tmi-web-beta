class MemosController < ApplicationController

  def create
    @memo = Memo.create!(memo_params)
    @memos = @memo.referrent && @memo.referrent.memos.order(updated_at: :desc) || []
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("memo-feed", partial: "/memos/feed", locals: { 
          memo: Memo.new(kind: @memo.kind, referrent_id: @memo.referrent_id),
          memos: @memos
        })
      end
    end
  end

  def show
    return unless @memo = Memo.find(params[:id])
    @memos = @memo.referrent && @memo.referrent.memos.order(updated_at: :desc) || []
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("memo-feed", partial: "/memos/feed", locals: { 
          memo: Memo.new(kind: @memo.kind, referrent_id: @memo.referrent_id),
          memos: @memos
        })
      end
    end
  end
  
  def destroy
    return unless @memo = Memo.find(params[:id])
    @memos = @memo.referrent && @memo.referrent.memos.order(updated_at: :desc) || []
    @memo.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("memo-feed", partial: "/memos/feed", locals: { 
          memo: Memo.new(kind: @memo.kind, referrent_id: @memo.referrent_id),
          memos: @memos
        })
      end
    end
  end
  
  def edit
    return unless @memo = Memo.find(params[:id])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("memo-#{@memo.id}", partial: "/memos/form", locals: { memo: @memo })
      end
    end
  end
  
  def update
    return unless @memo = Memo.find(params[:id])
    @memo.update_attributes(memo_params)
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
