class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    binding.pry
  end

  def destroy
  end

  private
  def set_plan
    
  end
end
