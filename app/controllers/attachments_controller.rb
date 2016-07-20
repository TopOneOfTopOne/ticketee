class AttachmentsController < ApplicationController
  # In ApplicationController an after_action is defined to verify that every
  # action is authorized. In this case we want to skip this. If we don't
  # an error will be thrown due to the aforementioned callback.
   skip_after_action :verify_authorized, only: [:new]

  def show
    attachment = Attachment.find(params[:id])
    authorize attachment
    # instead of rendering a view or redirecting we send a file
    send_file attachment.file.path, disposition: :inline
  end

  def new
    @ticket = Ticket.new
    @ticket.attachments.build
    @index = params[:index].to_i
    # just render the new view and nothing else e.g. nav bar
    render layout: false
  end
end
