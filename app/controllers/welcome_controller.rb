require 'json'

class WelcomeController < ApplicationController
  respond_to :json, :html, :xml

  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    @time = Time.now
    @user = current_user.nil? ? 'Stranger' : current_user.email.split('@')[0]
    @routes = Route.all

    respond_to do |format|
      format.json { render json: @routes, except: %w(user_id _id) }
      format.xml { render xml: @routes, except: %w(user_id _id) }
      format.html
    end
  end

  def create
    user = User.find_for_database_authentication(:api_key => params[:api_key])
    params[:welcome][:user] = user

    new_route = Route.create(route_params.except(:api_key))

    respond_to do |format|
      format.json { render json: user.presence ?  new_route : :error }
    end
  end


  def help
    @text = "Don't bother!"
  end

  private

    def route_params
      params.except(:api_key).require(:welcome).permit!
    end
end
