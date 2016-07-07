class AttachmentsController < ApplicationController

  def show
    attachment = Attachment.find(params[:id])
    authorize attachment
    # instead of rendering a view or redirecting we send a file
    send_file attachment.file.path, disposition: :inline
  end
end
