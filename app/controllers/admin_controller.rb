class AdminController < ApplicationController

  def home
    @users = User.all
  end

  def analytics

  end

  def users
    @users = User.all
  end
end