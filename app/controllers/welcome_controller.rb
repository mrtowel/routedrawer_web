class WelcomeController < ApplicationController
  def index
  	@time = Time.now
  end

  def help
  	@text = "Don't botherś!"
  end
end
