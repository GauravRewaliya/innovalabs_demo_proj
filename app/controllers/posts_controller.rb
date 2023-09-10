class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_user
  before_action :set_post , only: [ :destroy,:update , :edit]
  
  def index
    @posts = Post.all
    respond_to do |format|
      format.json { render json: @posts}
      format.html { render :index }
    end
  end

  def destroy
    respond_to do |format|
        format.json
        if (!@post.blank? && @post.destroy )
          render json: {notice: "post was successfully destroyed"}
        else
          render json: {notice: "cant delete"}, status: :unprocessable_entity  
        end
    end
  end

  def new
    @post = Post.new
  end
  def edit
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.json { render json: { status: :created, post: @post} }
        format.html { redirect_to posts_path, notice: "Tech_stack was successfully created." }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    respond_to do |format|
      if !@post.blank? 
        if @post.update(post_params)
          format.json { render json: { status: :updated, post: @post} }
          format.html { redirect_to posts_path, notice: "post was successfully updated." }
        else
          format.json {render json: {post: @post.errors, status: :unprocessable_entity} } 
          format.html { render :edit, status: :unprocessable_entity }
        end
      else
        format.json { render json: {notice: "cant find the post"}, status: :unprocessable_entity  }
      end  
    end
  end

  private

    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit( :title , :body)
    end

    def check_user
      if( session[:user_id] && (@user = User.find_by(id: session[:user_id])) )

      else
        respond_to do |format|
            format.json { render json: {notice: "need to login" }, status: :unauthorized }
            format.html { redirect_to users_login_view_path , notice: "need to login" }
        end
      end
      
    end
end
