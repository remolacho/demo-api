# frozen_string_literal: true

class DynamoDb::Delete < DynamoDb::Setup
  class << self
    def tables
      return unless check_env?

      DynamoDb::Models::DYNAMOID_MODELS.each  do |m|
        m.delete_table
      end
    end
  end
end
