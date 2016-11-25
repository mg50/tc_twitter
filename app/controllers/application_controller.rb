class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_app(props)
    render component: 'App', props: {currentUserId: current_user.try(:id)}.merge(props)
  end
end
