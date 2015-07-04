class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user! 
  respond_to :html

  def index
    @profiles = Profile.all
    respond_with(@profiles)
  end

  def show
    
    redirect_to new_profile_path if @profile.nil?
  end

  def new
    @profile = Profile.new
    respond_with(@profile)
  end

  def edit
  end


  def get_profile_data
    
     session["omniauth_target"] = "get_profile_data"

    if current_user.nil? or current_user.identities.first.token_expired?
      redirect_to sign_in_path
    end
    
    @graph = Koala::Facebook::API.new(current_user.identities.first.token)

    @my_info = @graph.get_object("me")

  end


  def create
    @profile = Profile.new(profile_params)
    @profile.save
    respond_with(@profile)
  end

  def update
    @profile.update(profile_params)
    respond_with(@profile)
  end

  def destroy
    @profile.destroy
    respond_with(@profile)
  end

  private
    def set_profile
      @profile = current_user.profile
    end

    def profile_params
      params.require(:profile).permit(:birthday, :city, :country, :age, :gender, :user_id)
    end
end
