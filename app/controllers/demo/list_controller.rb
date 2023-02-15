class Demo::ListController < ApplicationController
  def index
    render json: { data: User.all }, status: 200
  end
end
