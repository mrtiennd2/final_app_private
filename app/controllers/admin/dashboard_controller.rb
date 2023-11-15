class Admin::DashboardController < ApplicationController
  def index
    @users = User.where.not(is_admin: true)
  end
end
