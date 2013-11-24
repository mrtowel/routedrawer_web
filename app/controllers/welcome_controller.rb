require 'json'

class WelcomeController < ApplicationController
  respond_to :json, :html, :xml
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    user = User.find_for_database_authentication(:api_key => params[:api_key])
    if user.present?
      params[:welcome][:user] = user

      @new_location = Location.create(location_params.except(:api_key))
      respond_to do |format|
        format.json { render json: @new_location }
      end
    else
      respond_to do |format|
        format.json { render json: :error }
      end
    end
  end

  def index
    @time = Time.now
    @user = current_user.nil? ? "Stranger" : current_user.email.split('@')[0]
    @locations = Location.all

    respond_to do |format|
      format.json { render json: @locations, except: %w(user_id _id) }
      format.xml { render xml: @locations, except: %w(user_id _id) }
      format.html
    end
  end

  def help
    @text = "Don't bother!"
  end

  private

  def location_params
    params.except(:api_key).require(:welcome).permit!
  end
end
