class RegistrationController < ApplicationController
  def initialize
    @info = 'Registrations are not open yet, but please check back soon'
  end
  
  def new
  	redirect_to root_path, notice: @info
  end

  def create
  	redirect_to root_path, notice: @info
  end
end
