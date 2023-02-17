class Demo::UserController < ApplicationController
  def index
    render json: { data: User.all, success: true }, status: 200
  end

  def create
    user = User.create(allowed_params)
    render json: { data: user.attributes, success: true }, status: 200
  end

  def import
    limit =  params[:limit].to_i
    limit = limit.zero? ? 1000 : limit

    users = []

    0..limit.times do |i|
      users << {
        name: "Jhon#{i}",
        lastname: "Due#{i}",
        token: SecureRandom.hex,
        row: ["test#{i}", i, active?(i)]
      }
    end

    ImportUsersJob.perform_later(:create, { users: users })

    render json: { message: "se crearan en segundo plano" }, status: 200
  end

  def delete_all
    User.delete_all

    render json: { message: "se eliminaron todos los registros" }
  end

  private

  def active?(i)
    i%2 == 0
  end

  def allowed_params
    params.require(:user).permit(:name, :lastname, :token, row: [])
  end
end
