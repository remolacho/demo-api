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

  global_secondary_index hash_key: :token
end