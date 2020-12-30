class PostsController < ApplicationController
	 before_action :find_post, only: [:show, :update, :edit, :destroy]
	 before_action :authenticate_authentication!, except: [:index, :show]
	 before_action :correct_authentication, only: [:edit, :update, :destroy]

	def index
		@posts = Post.order("created_at DESC").page params[:page]
	end

	def new
		@post = current_authentication.posts.build
	end

	def create
		@post = current_authentication.posts.build(post_params)

		respond_to do |format|
			if @post.save
				format.html { redirect_to @post, notice: 'New post is successfully created!'}
				format.json { render :show, status: :created, location: @post}
			else
				format.html { render :new}
				format.json { render json: @post.errors, status: :unprocessable_entity}
			end
		end
	end

	def show
	end

	def update
		respond_to do |format|
			if @post.update(post_params)
				format.html { redirect_to @post, notice: 'Post was successfully updated!'}
				format.json { render :show, status: :ok, location: @post}
			else
				format.html { render :edit}
				format.json { render json: @post.errors, status: :unprocessable_entity}
			end
		end
	end

	def edit
	end

	def destroy
		@post.destroy
		respond_to do |format|
			format.html { redirect_to posts_path, notice: 'Post was successfully deleted.'}
			format.json { head :no_content}
		end
	end

	def correct_authentication
		@post = current_authentication.posts.find_by(id: params[:id])
		redirect_to posts_path, notice: "Not Authorized to Edit This Post" if @post.nil?
	end

	private

		def post_params
			params.require(:post).permit(:title, :content, :authentication_id)
		end

		def find_post
			@post = Post.find(params[:id])
		end

end
