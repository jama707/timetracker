class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    if params[:slug]
      @project = Project.find_by_slug(params[:slug])
    else
      @project=Project.find(params[:id])
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project].permit(:name, :default_rate, :slug, :company_id))
    if @project.save
      flash[:notice] ='Project created'
      redirect_to @project
    else
      render 'new'
    end
  end
end
