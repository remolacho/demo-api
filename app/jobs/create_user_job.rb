# frozen_string_literal: true

class CreateUserJob < ApplicationJob

  def create
    puts "event #{event.inspect}"
    sleep(2)
    User.create(event)
  end
end