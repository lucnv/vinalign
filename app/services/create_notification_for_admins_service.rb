class CreateNotificationForAdminsService
  attr_reader :notifiable, :action, :creator, :data

  def initialize creator, notifiable, action, data = {}
    @notifiable = notifiable
    @action = action
    @creator = creator
    @data = data
  end

  def perform
    User.admin.includes(:user_profile).each do |user|
      user.user_profile.received_notifications.create notifiable: notifiable,
        action: action, creator: creator, data: data
    end
  end
end
