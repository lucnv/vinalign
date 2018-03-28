class MyPage::BaseController < ApplicationController
  before_action :require_sign_in!

  layout :choose_layout

  private
  def choose_layout
    current_user.admin? ? "admin" : "clinic_management"
  end
end
