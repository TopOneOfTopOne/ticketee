class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, except: [:create, :new]

  def show
    authorize @ticket
  end

  def new
    @ticket = @project.tickets.build
    authorize @ticket, :create?
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user
    authorize @ticket

    if @ticket.save
      # [@project, @ticket] resolves to project_ticket_path(@project, @ticket)
      redirect_to [@project, @ticket], notice: "Successfully created ticket"
    else
      flash.now[:alert] = "Failed to create ticket"
      render "new"
    end
  end

  def edit
    authorize @ticket, :update?
  end

  def update
    authorize @ticket
    if @ticket.update(ticket_params)
      redirect_to [@project, @ticket], notice: "Updated ticket successfully"
    else
      flash.now[:error] = "Failed to update ticket"
      render :edit
    end
  end

  def destroy
    authorize @ticket
    @ticket.destroy
    redirect_to root_url, notice: "Deleted ticket successfully"
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    rescue
      redirect_to root_url, alert: "No project exists"
    end

    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    rescue
      redirect_to root_url, alert: "No ticket exists for given project"
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description, :attachment, :attachment_cache)
    end
end
