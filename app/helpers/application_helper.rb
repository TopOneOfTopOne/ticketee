module ApplicationHelper
  def title(*parts)
    return false if parts.empty?
    content_for :title do
      parts << "Ticketee"
      parts.join(" - ")
    end
  end

  def admin_only(&block)
    block.call if current_user.try(:admin?)
  end
end
