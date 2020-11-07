class ApplicationController < ActionController::API
  include Authenticable

  protected

  def check_authorization
    head :forbidden unless self.current_user
  end
end
