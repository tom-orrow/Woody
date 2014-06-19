class MainController < ApplicationController
  def index
    @projects = Project.all()
    @categories = Category.all()
  end
end
