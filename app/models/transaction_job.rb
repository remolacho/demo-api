# frozen_string_literal: true

class TransactionJob < ApplicationItem
  table(
    name: "transaction_jobs",
    key: :id
  )

  field :token, :string
  field :model, :string
  field :call_back, :string
  field :status, :integer
  field :amount_jobs, :integer
  field :processed_jobs, :integer
  field :error, :string

  global_secondary_index hash_key: :token

  has_many :users
end