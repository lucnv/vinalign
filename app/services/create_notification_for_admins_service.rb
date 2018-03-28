class CreateNotificationForAdminsService
  attr_reader :notifiable, :action

  def initialize notifiable, action
    @notifiable = notifiable
    @action = action
  end

  def perform
    User.admin.includes(:user_profile).each do |user|
      user.user_profile.received_notifications.create notifiable: notifiable,
        action: action
    end
  end
end
