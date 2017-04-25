class SubsController < ApplicationController
  before_action :check_mod, only: [:edit, :update, :destroy]
  # GET /subs
  def index
    @subs = Sub.all
  end

  # GET /subs/1
  def show
    @sub = Sub.find(params[:id])
  end

  # GET /subs/new
  def new
    @sub = Sub.new
  end

  # GET /subs/1/edit
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  # POST /subs
  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to @sub, notice: 'Sub was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /subs/1
  def update
    if @sub.update(sub_params)
      redirect_to @sub, notice: 'Sub was successfully updated.'
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to edit_sub_url(@sub)
    end
  end

  # DELETE /subs/1
  def destroy
    @sub = current_user.subs.find(params[:id])
    @sub.destroy
    redirect_to subs_url, notice: 'Sub was successfully deleted.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_params
      params.require(:sub).permit(:title, :description, :user_id)
    end

    def check_mod
      @sub = Sub.find(params[:id])
      redirect_to(sub_url(@sub)) unless @sub.moderator == current_user
    end
end
