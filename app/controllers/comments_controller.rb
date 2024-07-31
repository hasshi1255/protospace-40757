class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prototype, only: [:create]

  def create
    @comment = @prototype.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      @comments = @prototype.comments.includes(:user)
      render 'prototypes/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end
end