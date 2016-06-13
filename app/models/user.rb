class User < ActiveRecord::Base
  scope :exclude_archived, -> { where(archived_at: nil) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets

  def to_s
    email + " " + (admin? ? "(Admin)" : "(User)")
  end

  def archive
    update(archived_at: Time.now)
  end

  def active_for_authentication?
    super && archived_at.nil?
  end

  def inactive_message
    archived_at.nil? ? super : :archived
  end
end
