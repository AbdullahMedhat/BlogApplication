class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update verify verify_thats_me]
  before_action :authenticate_user!, only: %i[new edit]
  before_action :verify_user_number, only: [:new]
  before_action :authenticate_current_user, only: %i[edit verify]

  def index
    @blogs = Blog.all.published
  end

  def show; end

  def new
    @blog = Blog.new
  end

  def edit; end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user

    if @blog.save
      redirect_to @blog
    else
      render :new
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit
    end
  end

  # This action for return all drafted and publish blogs for current_user
  def myblogs
    @drafted_blogs = current_user.blogs.drafted.order('id DESC')
    @published_blogs = current_user.blogs.published.order('id DESC')
  end

  # This action for verfiy a user to publish his/her blog
  def verify
    @response = Authy::API.request_sms(id: current_user.authy_id)
    @user_phone = current_user.country_code + current_user.phone_number
  end

  # This action for check user verification after entered the code
  def verify_thats_me
    response = Authy::API.verify(
      id: current_user.authy_id, token: params[:token], force: true
    )
    if response.ok?
      @blog.update(state: 'published')
      redirect_to blog_path(@blog)
    else
      redirect_to blog_verify_path, notice: 'Token is wrong or expired!'
    end
  end

  private

  def authenticate_current_user
    redirect_to root_path unless current_user.blogs.include? @blog
  end

  def verify_user_number
    redirect_to edit_user_registration_path if current_user.phone_number.nil?
  end

  def set_blog
    @blog = Blog.find(params[:id])
    @current_user = current_user
  end

  def blog_params
    params.require(:blog).permit(
      :title, :description, :content
    )
  end
end
