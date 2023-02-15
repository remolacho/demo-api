class Demo::UserController < ApplicationController
  def index
    render json: { data: User.all, success: true }, status: 200
  end

  def create
    user = User.create(allowed_params)
    render json: { data: user.attributes, success: true }, status: 200
  end

  def import
    0..1000.times do |i|
      user = {
        name: "Jhon#{i}",
        lastname: "Due#{i}",
        token: SecureRandom.hex,
        row: ["test#{i}", i, active?(i)]
      }

      ImportUsersJob.perform_later(:create, user)
    end

    render json: { message: "se crearan en segundo plano" }, status: 200
  end

  private

  def active?(i)
    i%2 == 0
  end

  def allowed_params
    params.require(:user).permit(:name, :lastname, :token, row: [])
  end
end
