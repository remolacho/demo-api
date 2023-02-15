# frozen_string_literal: true

class ::DynamoDb::Seed::User < ::DynamoDb::Setup
  class << self
    def import
      return unless check_env?

      User.import([
                    { name: "jhon", lastname: "due", row: ["test1", 1, true]},
                    { name: "jhon2", lastname: "due2", row: ["test2", 2, false]}
                  ])
    end
  end
end
