class CoursesController < ApplicationController

  def index
      courses = Course.all
      render json:{courses: courses}, status: 200
  end

  def create
    if @current_user["user_type"] != "admin"
      return render json: { message: "Permission Denied " }, status: :unauthorized
    end
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
    render json: {course: course, subtracks: course&.subtracks}
  end

  private
  def course_params
    params.require(:course).permit(:courseCode, :name, :description)
  end
end