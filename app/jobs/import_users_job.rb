# frozen_string_literal: true

class ImportUsersJob < ApplicationJob

  def create
    event[:users].each do |user|
      CreateUserJob.perform_later(:create, user)
    end
  end
end