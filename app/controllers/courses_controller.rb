class CoursesController < ApplicationController
  def index
      courses = Course.all
      render json:{courses: courses}, status: 200
  end

  def create
    new_course = Course.new(course_params)
    if new_course.valid?
      new_course.save

      render json: new_course, status: 201
    else
      render json: new_course.errors.details, status: 400
    end
  end

  def show
    course = Course.find_by_id(params['id'])
    render json: {course: course}
  end

  private
  def course_params
    params.require(:course).permit(:courseCode, :name, :description)
  end
end