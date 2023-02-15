# frozen_string_literal: true

class DynamoDb::Setup
  # List all your Dynamoid models here:

  class << self

    def tables
      raise NotImplementedError, "the method tables wasn't implement"
    end

    def check_env!
      return if ENV['JETS_ENV'] == 'local'

      raise "Do not run on production envs!"
    end
  end
end
