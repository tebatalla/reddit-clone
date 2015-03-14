class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(votable: @comment, voter_id: current_user.id, value: 1)
    if @vote.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @vote.errors.full_messages
      redirect_to post_url(@comment.post)
    end
  end

  def downvote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(votable: @comment, voter_id: current_user.id, value: -1)
    if @vote.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @vote.errors.full_messages
      redirect_to post_url(@comment.post)
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :post_id, :parent_comment_id)
    end
end
