task :password_date_update => :environment do
    users = User.all
        users.each do |user|
            user.update(p_updated_at: user.created_at)
        end
  end
