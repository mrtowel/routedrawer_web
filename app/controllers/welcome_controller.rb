class WelcomeController < ApplicationController
  def index
  	@time = Time.now
  	@user = current_user.nil? ? "Stranger" : current_user.email.split('@')[0]
  end

  def help
  	@text = "Don't bother!"
  end
end
