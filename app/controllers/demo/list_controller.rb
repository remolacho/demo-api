class Demo::ListController < ApplicationController
  def index
    render json: {data: [{id: 1, name: 'jhon', lastname: 'due'}], url_db: ENV['EP_URL_DYNAMO_DB']}, status: 200
  end
end
