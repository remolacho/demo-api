# frozen_string_literal: true

class ::DynamoDb::Seed::User < ::DynamoDb::Setup
  class << self
    def import
      check_env!

      User.import([
                    { name: "jhon", lastname: "due"},
                    { name: "jhon2", lastname: "due2"}
                  ])
    end
  end
end
