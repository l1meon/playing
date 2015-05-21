class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :set_online

  private

    def set_online
      if !!current_user
        $redis.set(current_user.email, nil, ex: 10*60)
      end
    end

end
