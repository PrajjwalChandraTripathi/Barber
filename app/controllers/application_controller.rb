class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session, if: -> { request.format.json? }

    before_action :authenticate_user!

    def authenticate_admin!
      redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
    end
  
    def authenticate_client!
      redirect_to root_path, alert: 'Not authorized' unless current_user.client?
    end
  
    def authenticate_customer!
      redirect_to root_path, alert: 'Not authorized' unless current_user.customer?
    end
end
