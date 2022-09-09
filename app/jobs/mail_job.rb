class MailJob < ApplicationJob
    queue_as :default
  
    def perform(user_id)
      users = User.other_active_users(user_id)
      p "Email sent to"
      users.each do |user|
        p user[:email]
      end
    end
  end