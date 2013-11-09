require 'json'

class WelcomeController < ApplicationController
  respond_to :json, :html, :xml
  
  def index
  	@time = Time.now
  	#@user = current_user.nil? ? "Stranger" : current_user.email.split('@')[0]
  	@locations = Location.all
  	
  	respond_to do |format|
      format.json { render json: @locations, except: 'user_id' }
      format.xml { render xml: @locations, except: 'user_id' }
      format.html
	  end
  end

  def help
  	@text = "Don't bother!"
  end
end
