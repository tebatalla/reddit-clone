class SubsController < ApplicationController
  before_action :is_moderator?, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.try(:destroy)
    redirect_to subs_url
  end

  def update
    @sub = Sub.update(params[:id], sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  private

    def is_moderator?
      @sub = Sub.find(params[:id])
      unless @sub.moderator_id == current_user.id
        flash.now[:errors] = "Not authorized"
        redirect_to sub_url(@sub)
      end
      true
    end

    def sub_params
      params.require(:sub).permit(:title, :description)
    end
end
