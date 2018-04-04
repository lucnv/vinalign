class CreateNotificationForAdminsService
  attr_reader :notifiable, :action, :creator

  def initialize creator, notifiable, action
    @notifiable = notifiable
    @action = action
    @creator = creator
  end

  def perform
    User.admin.includes(:user_profile).each do |user|
      user.user_profile.received_notifications.create notifiable: notifiable,
        action: action, creator: creator
    end
  end
end
