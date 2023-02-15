# frozen_string_literal: true

class PubSubCreateUser < Jets::Stack
  sns_topic(:delivery_completed, display_name: "demo-api-dev-create-user")
end
