class CommentsController < ApplicationController
  before_action :load_post

  # GET /posts/:post_id/comments
  # GET /posts/:post_id/comments.json
  def index
    @comments = @post.comments
  end

  # GET /posts/:post_id/comments/:id
  # GET /comments/:id.json
  def show
    @comment = @post.comments.find(params[:id])
  end

  # GET /posts/:post_id/comments/new
  def new
    @comment = @post.comments.build
  end

  # GET /posts/:post_id/comments/:id/edit
  def edit
    @comment = @post.comments.find(params[:id])
  end

  # POST /posts/:post_id/comments
  # POST /posts/:post_id/comments.json
  def create
    @comment = @post.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@comment.post, @comment], notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: [@comment.post, @comment] }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/:post_id/comments/:id
  # PATCH/PUT /posts/:post_id/comments/:id.json
  def update
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to [@comment.post, @comment], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: [@comment.post, @comment] }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/:post_id/comments/1
  # DELETE /posts/:post_id/comments/1.json
  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_post
      @post = Post.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:author, :body, :post_id)
    end
end
