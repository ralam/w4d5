class PostsController < ApplicationController
  before_action :is_author, only:[:edit, :update]

  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      params[:post][:sub_id].each do |id|
        PostSub.new(sub_id: id, post_id: @post.id).save
      end
      redirect_to sub_post_url(@post.sub_id, @post.id)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_post_url(@post.sub_id, @post.id)
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id => [])
  end

  def is_author
    @post = Post.find(params[:id])
    if @post.author_id != current_user.id
      redirect_to sub_post_url(@post.sub_id, @post.id)
    end
  end
end
