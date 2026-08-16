module Courses
  class CreateService
    def initialize(course_params:, tutors_params:)
      @course_params = course_params
      @tutors_params = tutors_params
    end

    def call
      Course.transaction do
        course = Course.create!(course_params)

        course.tutors.create!(tutors_params)

        course
      end
    end

    private

    attr_reader :course_params, :tutors_params
  end
end
