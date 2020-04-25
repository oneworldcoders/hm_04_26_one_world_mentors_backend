class CoursesController < ApplicationController
    
  def courses
      courses = Course.all
      render json:{courses: courses}, status: 200
  end
end