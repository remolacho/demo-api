# frozen_string_literal: true

class DynamoDb::Create < DynamoDb::Setup
  class << self
    def tables
      return unless check_env?

      DynamoDb::Models::DYNAMOID_MODELS.each do |m|
        puts "Creating table: #{m.table_name}..."
        m.create_table(sync: true)
      end
    end
  end
end
