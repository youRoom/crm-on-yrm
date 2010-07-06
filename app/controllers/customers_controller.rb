class CustomersController < ApplicationController
  before_filter :set_group

  def index
    @customers = Customer.all(params[:page], client, group_param)
  end

  def show
    @customer = Customer.find(params[:id], client, group_param)
  end

  def new
    @customer = Customer.new
  end

  def create
    result, @customer = Customer.create(params[:customer], client, group_param)
    if result
      flash[:notice] = "Successfully created customer."
      redirect_to :action => :index
    else
      render :action => 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id], client, group_param)
  end

  def update
    result, @customer = Customer.update(params[:customer], client, group_param, params[:id])
    if result
      flash[:notice] = "Successfully updated customer."
      redirect_to :action => :show, :id => @customer.id
    else
      render :action => 'edit'
    end
  end

  def group_param
    session[:group]
  end

  def set_group
    session[:group] = ERB::Util.h(params[:group]) if params[:group]
    session[:group] = nil if params[:reset_group]
    if session[:group].blank?
      logger.info "[youRoom API] Get: #{Customer.base_url_without_group}/groups/my.json"
      @groups = JSON.parse(client.get("#{Customer.base_url_without_group}/groups/my.json").body)
      render "select_group"
    end
  end
end
