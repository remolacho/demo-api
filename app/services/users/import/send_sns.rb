# frozen_string_literal: true

class Users::Import::SendSns
  include Jets::AwsServices

  def deliver
    topic_arn = PubSubCreateUser.lookup(:delivery_completed) # looks up output from the Alert cfn stack

    0..50.times do |i|
      user = {
        name: "Jhon#{i}",
        lastname: "Due#{i}",
        token: SecureRandom.hex,
        row: ["test#{i}", i, active?(i)]
      }

      sns.publish(
        topic_arn: topic_arn,
        subject: "create user",
        message: user
      )
    end

    { message: 'Se crearan en segundo plano!!!!' }
  end
end
