# frozen_string_literal: true

class CreateUserJob < ApplicationJob

  def create
    sleep(2)

    puts "CreateUserJob #####################################################################"

    user = User.create!(event[:user].merge({ status: 1, error:  '' }))

    transaction_jobs.finish(user.transaction_id)
  rescue StandardError => e
    user = User.create!(event[:user].merge({ status: 2, error: e.to_s }))

    transaction_jobs.finish(user.transaction_id)
  end

  private

  def transaction_jobs
    @transaction_jobs ||= Transactions::Run.new
  end
end
