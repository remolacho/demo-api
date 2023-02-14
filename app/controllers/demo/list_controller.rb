class Demo::ListController < ApplicationController
  def index
    render json: {data: [{id: 1, name: 'jhon', lastname: 'due'}]}, status: 200
  end
end
