# frozen_string_literal: true

class User < ApplicationItem
  table(
    name: "users",
    key: :id
  )

  field :name, :string
  field :lastname, :string
  field :token, :string
  field :row, :array
  field       :transaction_id, :string
  field :error, :integer

  belongs_to :transaction_job

  global_secondary_index hash_key: :token
  global_secondary_index hash_key: :transaction_id
end