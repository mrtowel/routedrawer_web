require 'json'

class WelcomeController < ApplicationController
  respond_to :json, :html, :xml
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    user = User.find_for_database_authentication(:api_key => params[:api_key])
    if user.present?
      @new_location = Location.create(:lat => params[:lat], :lng => params[:lng])

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


    unless current_user.nil?
      respond_to do |format|
        format.json { render json: @locations, except: 'user_id' }
        format.xml { render xml: @locations, except: 'user_id' }
        format.html
      end
    end
  end

  def help
  	@text = "Don't bother!"
    respond_to do |format|
      format.json { render json: @locations, except: 'user_id' }
    end
  end
end
