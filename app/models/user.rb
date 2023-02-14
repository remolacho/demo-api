# frozen_string_literal: true

class User
  include Dynamoid::Document

  table(
    name: "users",
    key: :id
  )

  field :name, :string
  field :lastname, :string
end