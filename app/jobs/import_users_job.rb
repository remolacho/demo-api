# frozen_string_literal: true

class ImportUsersJob < ApplicationJob

  def create
    puts "event #{event.inspect}"
    sleep(5)
    User.create(event)
  end
end