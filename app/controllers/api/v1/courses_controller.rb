module Api
  module V1
    class CoursesController < BaseController
      def index
        courses = Course.includes(:tutors).order(:id)

        render json: courses.map { |course| CourseSerializer.new(course).as_json }
      end

      def create
        course = Courses::CreateService.new(
          course_params:,
          tutors_params:
        ).call

        render json: CourseSerializer.new(course).as_json,
               status: :created
      end

      private

      def course_params
        params.require(:course).permit(
          :name,
          :description,
          :status
        )
      end

      def tutors_params
        params.fetch(:tutors, []).map do |tutor|
          tutor.permit(
            :name,
            :email,
            :experience_years
          )
        end
      end
    end
  end
end
