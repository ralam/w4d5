class PostsController < ApplicationController
  #before_action :is_author, only:[:edit, :update]

  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      params[:post][:sub_ids].each do |id|
        PostSub.new(sub_id: id, post_id: @post.id).save
      end
      redirect_to sub_post_url(params['sub_id'], @post.id)
    else
      render :new
    end
  end

  def edit

    @post = Post.find(params[:id])
    @subs = Sub.all
    @post_subs = @post.post_subs.map {|post| post.sub_id }
  end

  def update

    @post = Post.find(params[:id])
    #@post_subs = PostSub.find_by(post_id: params[:id]).select(:sub_id <> params)

    @post.author_id =current_user.id
    fail
    if @post.update(post_params)
      redirect_to subs_url
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids)
  end


end
