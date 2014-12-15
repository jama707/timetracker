class WorksController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]

  # protect_from_forgery
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
    @work =Work.new(params[:work].permit(:project_id, :datetimeperformed, :hours))
    @work.user = current_user;
    uploaded_io =  params[:work][:doc]
    if uploaded_io
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
        @work.doc = uploaded_io.original_filename
      end
    end
    respond_to do |format|
      if @work.save
        Usermailer.workcreated_email(@work).deliver
        format.html { redirect_to @work, notice: 'Work created' }
        format.js {}
      else
        format.html { render 'new' }
        format.js {}
      end

    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(params[:work].permit(:project_id, :datetimeperformed, :hours))
      flash[:notice]= 'Work updated'
      redirect_to @work
    else
      render 'edit'
    end
  end

end
