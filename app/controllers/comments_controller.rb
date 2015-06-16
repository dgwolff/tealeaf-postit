class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      redirect_to :back
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.create(voteable: comment, creator: current_user,
                       vote: params[:vote])

    if vote.valid?
      flash[:notice] = "Your vote was counted"
    else
      flash[:error] = "You've already voted on this comment"
    end

    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
