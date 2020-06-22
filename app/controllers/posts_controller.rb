class PostsController < ApplicationController

  before_action :set_post, only: [:edit, :update, :destroy]
  skip_before_action :only_signed_in, only: [:species, :index, :show]

  def index
    pet_ids = current_user.followed_pets.pluck(:id)
    if pet_ids.empty?
      @posts = []
    else
      @posts = Post.joins('INNER JOIN pets_posts ON pets_posts.post_id = posts.id').where("pets_posts.pet_id IN (#{pet_ids.join(',')})")
    end
  end

  def species
    @species = Species.find_by_slug!(params[:slug])
    @posts = Post.joins(:pets).where(pets: {species_id: @species.id})
  end

  def me
    @posts = current_user.posts.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      p = params.require(:post).permit(:name, :content, :image_file, pet_ids: [])
      p[:pet_ids] = current_user.pets.where(id: p[:pet_ids]).pluck(:id)
      p
    end
end
