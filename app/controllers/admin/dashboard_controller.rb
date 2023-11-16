class Admin::DashboardController < ApplicationController
  layout 'index_with_pagination'

  def index
    @users = User.where.not(is_admin: true).page(params[:page])
  end
end
