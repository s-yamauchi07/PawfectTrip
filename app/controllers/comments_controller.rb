class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:index, :create, :edit, :update, :destroy]
  before_action :set_comment, only: [ :edit, :update, :destroy]
  before_action :set_comment_lists, only: [:index, :create, :update]
  before_action :check_user, only: [:edit, :update, :destroy]

  def index
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

      respond_to do |format|
        # binding.pry
        if @comment.save
          @comment.broadcast_prepend_later_to("comments_channel_#{@plan.id}")
          reset_form
          format.html { redirect_to plan_comments_path }
          format.turbo_stream
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        reset_form
        format.html { redirect_to plan_comments_path,notice: "Post was successfully created." }
        format.turbo_stream
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        reset_form
        @comments = @plan.comments.includes(:user)
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

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comment_lists
    @comments = @plan.comments.includes(:user)
  end

  def check_user
    unless @comment.user == current_user
      redirect_to plan_comments_path
    end
  end

  def reset_form
    @comment = Comment.new
  end
end
