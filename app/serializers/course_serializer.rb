class CourseSerializer
  def initialize(course)
    @course = course
  end

  def as_json
    {
      id: course.id,
      name: course.name,
      description: course.description,
      status: course.status,
      tutors: course.tutors.map do |tutor|
        {
          id: tutor.id,
          name: tutor.name,
          email: tutor.email,
          experience_years: tutor.experience_years
        }
      end
    }
  end

  private

  attr_reader :course
end
