# frozen_string_literal: true

class CreateUserJob < ApplicationJob

  def create
    sleep(2)

    puts "CreateUserJob #####################################################################"

    user = User.create!(event[:user].merge({ status: 1, error:  '' }))

    transaction_jobs.finish(user.transaction_id) do
      puts "se finalizaron todos los registros #####################################################################"
    end
  rescue StandardError => e
    user = User.create!(event[:user].merge({ status: 2, error: e.to_s }))

    transaction_jobs.finish(user.transaction_id) do
      puts "se finalizaron todos los registros #####################################################################"
    end
  end

  private

  def transaction_jobs
    @transaction_jobs ||= Transactions::Run.new
  end
end
