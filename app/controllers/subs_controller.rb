class SubsController < ApplicationController
  before_action :edit_update_sub, only: [:edit, :update]
  before_action :validate_user, except: [:show, :index]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["Did not create sub"]
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["Did not update sub"]
      render :edit
    end
  end


  def show
    @sub = Sub.find(params[:id])

    @posts = @sub.posts
  end

  def index
    @subs = Sub.all
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

  def edit_update_sub
    @sub = Sub.find(params[:id])
    unless current_user.id == @sub.moderator_id
      [:error] << "Wrong User"
    end
  end

  def validate_user
    unless session[:session_token]
      flash.now[:error] = ["Not Logged In"]
      redirect_to new_session_url
    end
  end
end
