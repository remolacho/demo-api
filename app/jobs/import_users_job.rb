# frozen_string_literal: true

class ImportUsersJob < ApplicationJob
  def create
    transaction_jobs.in_progress(event[:transaction_token]) do |transaction|
      0..transaction.amount_jobs.times do |i|
        user = {
          name: "Jhon#{i}",
          lastname: "Due#{i}",
          token: SecureRandom.hex,
          row: ["test#{i}", i, active?(i)],
          transaction_id: transaction.id
        }

        CreateUserJob.perform_later(:create, { user: user, transaction_id: transaction.id })
      end
    end
  rescue StandardError => e
    transaction_jobs.cancel(event[:transaction_token], e) do |transaction|
      transaction.users.delete_all
    end
  end

  private

  def transaction_jobs
    @transaction_jobs ||= Transactions::Run.new
  end

  def active?(i)
    i%2 == 0
  end
end