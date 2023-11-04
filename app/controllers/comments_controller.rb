class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:index, :create, :edit, :update]
  before_action :set_comments, only: [:index, :create, :update]

  def index
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

      respond_to do |format|
        if @comment.save
          # 入力フォームのリセットのために変数を再定義
          @comment = Comment.new
          format.html { redirect_to plan_comments_path }
          format.turbo_stream
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        @comment = Comment.new
        format.html { redirect_to plan_comments_path }
        format.turbo_stream
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, plan_id: params[:plan_id])
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def set_comments
    @comments = @plan.comments.includes(:user)
  end
end
