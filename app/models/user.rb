# frozen_string_literal: true

class User < ApplicationItem
  table(
    name: "users",
    key: :id
  )

  field :name, :string
  field :lastname, :string
  field :row, :array
end