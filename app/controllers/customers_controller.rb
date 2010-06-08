class CustomersController < ApplicationController
  before_filter :set_group

  def index
    @customers = Customer.all(params[:page], client, group_param)
  end

  def show
    @customer = Customer.find(params[:id], client, group_param)
  end

  def create
    success, @customer = Customer.create(params[:customer], client, group_param)
    if success
      flash[:notice] = "Successfully created customer."
      redirect_to :action => :index
    else
      render :action => 'new'
    end
  end

  def group_param
    session[:group]
  end

  def set_group
    session[:group] = ERB::Util.h(params[:group]) if params[:group]
    session[:group] = nil if params[:reset_group]
    if session[:group].blank?
      logger.info "[youRoom API] Get: #{Customer.base_url('home')}/groups/my.json"
      @groups = JSON.parse(client.get("#{Customer.base_url('home')}/groups/my.json").body)
      render "select_group"
    end
  end
end
