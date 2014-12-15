class CompaniesController < ApplicationController
  def index
    @companies=Company.all

  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company].permit(:name))
    @company.save
    if @company.save
      flash[:notice] = 'Company created'
      redirect_to @company
    else
      render 'new'
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(params[:company].permit(:name))
      flash[:notice] = 'Company updated'
      redirect_to @company
    else
      render 'edit'
    end
  end

end
