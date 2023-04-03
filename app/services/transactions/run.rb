# frozen_string_literal: true
module Transactions
  class Run
    attr_reader :resource

    def create(klass,  amount_jobs)
      transaction = TransactionJob.create(token: SecureRandom.uuid,
                                          status: 0,
                                          amount_jobs: amount_jobs,
                                          processed_jobs: 0,
                                          error: '',
                                          model: klass.camelcase)

      set_transaction(transaction)
      puts "Create transaction ###############################################################################"
      yield(resource) if block_given? && resource.present?
    rescue StandardError => e
      internal_cancel(e)
    end

    def in_progress(token)
      transaction = TransactionJob.find_by_token(token)
      transaction.status = 1
      transaction.save

      set_transaction(transaction)
      puts "in_progress transaction ###############################################################################"

      yield(resource) if block_given? && resource.present?
    rescue StandardError => e
      internal_cancel(e)
    end

    def cancel(token, error)
      transaction = TransactionJob.find_by_token(token)
      set_transaction(transaction)
      status_error(transaction, error)

      yield(transaction) if block_given? && resource.present?
    rescue StandardError => e
      internal_cancel(e)
    end

    def finish(transaction_id)
      transaction = TransactionJob.find(transaction_id)
      return if has_error?(transaction)

      data = load_meta_data(transaction)
      transaction.processed_jobs = data.total_records

      unless data.all_jobs_completed
        transaction.save
        return
      end

      transaction.status = 2
      transaction.save!

      set_transaction(transaction)

      yield(transaction) if block_given? && resource.present?

      puts "se finalizaron todos los jobs #####################################################################"
    rescue StandardError => e
      internal_cancel(e)
    end

    private

    def internal_cancel(transaction = @resource, error)
      status_error(transaction, error)
      raise StandardError, "Hubo un error en la transaccion #{error}"
    end

    def status_error(transaction, error)
      return unless transaction

      transaction.status = 3
      transaction.error = error
      transaction.save
    end

    def set_transaction(transaction)
      @resource = transaction
    end

    def load_meta_data(transaction)
      klass = Object.const_get(transaction.model)
      total_records = klass.where(transaction_id: transaction.id).count
      completed = total_records >= transaction.amount_jobs

      Struct.new(:all_jobs_completed, :total_records).new(completed, total_records)
    end

    def has_error?(transaction)
      transaction.status == 3
    end
  end
end
