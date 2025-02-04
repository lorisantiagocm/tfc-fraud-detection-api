module Api
  module V1
    class BaseController < ActionController::API
      include Devise::Controllers::Helpers
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound do |_exception|
        head :not_found
      end

      # rescue_from Pundit::NotAuthorizedError do |_e|
      #   head :forbidden
      # end

      def render_errors(errors)
        render json: { errors: errors }, status: :bad_request
      end
    end
  end
end
