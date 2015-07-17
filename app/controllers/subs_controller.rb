class SubsController < ApplicationController

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
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
    if @sub.update(params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["Did not update sub"]
      render :edit
    end
  end


  def show
    @sub = Sub.find(params[:id])
  end

  def index
    @subs = Sub.all
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
end
