class WorksController < ApplicationController
  def index
    if (params[:days])
      @works= Work.recentdays(params[:days]).order('datetimeperformed desc')
    else
      @works=Work.all.order('datetimeperformed desc')
    end
  end

  def show
    @work=Work.find(params[:id])
  end

  def new
    @work =Work.new
  end

  def create
    @work =Work.new(params[:work].permit(:project_id, :user_id, :datetimeperformed, :hours))
    @work.save
    flash[:notice]= 'Work created'
    redirect_to @work
  end

end
