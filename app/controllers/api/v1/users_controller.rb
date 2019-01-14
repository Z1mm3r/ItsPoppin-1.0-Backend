class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :find_user, only: [:show, :edit, :update, :destroy,:edit_establishments]

  def index
    @users = User.all
    output = []
    @users.each do |user|
      outputElement = user.toProtectedJson
      output.push(outputElement)
    end
    render :json => output.as_json
  end

  def profile
    render json: {user: UserSerializer.new(current_user)}, status: :accepted
  end

  def show
    render json: {user: UserSerializer.new(@user) }
  end

  def new
    @user = User.new
  end

  def create
    if params[:user][:password_confirmation]
      @user = User.create(new_user_params)
      if @user.valid?
        render json: {user: UserSerializer.new(@user) },status: :created
      else
        render json: {error: 'failed to create user' }, status: :not_acceptable
      end
    end
  end

  def update
    if( params[:user][:password_confirmation])
      @user.update(update_user_params)
      render json: {user: UserSerializer.new(@user) },status: :accepted
    else
      render json: {error: 'Failed to update user'},status: :not_acceptable
    end
  end

  def login
  end

  def edit_establishments
    @establishments = @user.establishments
    render json: @establishments.as_json(:only => [:id,:name,:domain,:rating,:genre,:picture_url,:address])
  end

  private

  def new_user_params
    params.require(:user).permit(:name,:password, :password_confirmation, :email)
  end

  def update_user_params
    params.require(:user).permit(:name,:password, :password_confirmation, :email,:profilePitureUrl)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
