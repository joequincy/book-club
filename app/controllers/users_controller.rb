class UsersController < ApplicationController
  def show
    @reviews = if params[:sort]
      direction = params[:direction] || 'DESC'
      case params[:sort]
      when 'date'
        Review.user_by_date(user: params[:id], dir: direction)
      when 'rating'
        Review.user_by_rating(user: params[:id], dir: direction)
      else
        Review.where(user: params[:id])
      end
    else
      Review.where(user: params[:id])
    end
  end
end
