class Demo::UserController < ApplicationController
  def index
    render json: { data: User.all, success: true }, status: 200
  end

  def create
    user = User.create(allowed_params)
    render json: { data: user.attributes, success: true }, status: 200
  end

  def import
    jobs_limit = params[:limit].to_i.zero? ? 50_000 : params[:limit].to_i

    transaction_jobs.create('User',  jobs_limit) do |transaction|
      ImportUsersJob.perform_later(:create, {transaction_token: transaction.token })
      render json: { message: "se crearan en segundo plano" }, status: 200
    end
  rescue StandardError => e
    render json: { message: e.to_s }, status: 400
  end

  def delete_all
    User.delete_all

    render json: { message: "se eliminaron todos los registros" }
  end

  private

  def transaction_jobs
    @transaction_jobs ||= Transactions::Run.new
  end

  def allowed_params
    params.require(:user).permit(:name, :lastname, :token, row: [])
  end
end
