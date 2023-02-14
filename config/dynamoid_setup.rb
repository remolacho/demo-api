# frozen_string_literal: true

class DynamoidSetup
  # List all your Dynamoid models here:
  DYNAMOID_MODELS = [User].freeze

  class << self
    def create_tables
      check_env!

      DYNAMOID_MODELS.each do |m|
        puts "Creating table: #{m.table_name}..."
        m.create_table(sync: true)
      end
    end

    def delete_tables
      check_env!

      DYNAMOID_MODELS.each do |m|
        m.delete_table
      end
    end

    def check_env!
      return if Rails.env.development? || Rails.env.test?

      raise "Do not run on production envs!"
    end
  end
end
