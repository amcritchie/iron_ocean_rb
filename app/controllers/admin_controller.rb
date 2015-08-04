class AdminController < ApplicationController

  def home

  end

  def analytics

  end

  def users
    @users = User.all
  end
end