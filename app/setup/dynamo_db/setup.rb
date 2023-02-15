# frozen_string_literal: true

class DynamoDb::Setup
  # List all your Dynamoid models here:

  class << self

    def tables
      raise NotImplementedError, "the method tables wasn't implement"
    end

    def check_env?
      return false unless ENV['JETS_ENV'] == 'local' || ENV['JETS_ENV'] == 'development'

      true
    end

  end
end
