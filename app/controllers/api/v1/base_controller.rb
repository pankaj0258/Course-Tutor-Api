module Api
  module V1
    class BaseController < ActionController::API
      rescue_from ActiveRecord::RecordInvalid, with: :render_validation_error

      private

      def render_validation_error(exception)
        render json: {
          errors: exception.record.errors.full_messages
        }, status: :unprocessable_content
      end
    end
  end
end
