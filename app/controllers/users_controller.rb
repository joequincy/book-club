class UsersController < ApplicationController
  def show
    @reviews = if params[:sort] == 'date'
      direction = params[:direction] || 'DESC'
      Review.user_by_date(user: params[:id], dir: direction)
    else
      Review.where(user: params[:id])
    end
  end
end
