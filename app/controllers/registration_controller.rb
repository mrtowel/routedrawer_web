class RegistrationController < ApplicationController
  def initialize
    @info = 'Registrations are not open yet, but please check back soon'
  end
  
  def new
  	@info
  	redirect_to root_path
  end

  def create
  	@info
  	redirect_to root_path
  end
end
