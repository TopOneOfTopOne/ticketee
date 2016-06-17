class Project < ActiveRecord::Base
  validates :name, presence: true

  # `:destroy` will go through tickets one by one and delete them when the project is
  # deleted. This can be slow so there is `:delete_all` which will delete all
  # tickets at once and ignore all callbacks.
  has_many :tickets, dependent: :destroy
  has_many :roles, dependent: :destroy

  def has_member?(user)
    roles.exists? user_id: user
  end

  [:viewer, :manager, :editor].each do |role|
    define_method "has_#{role}?" do |user|
      roles.exists? user_id: user, role: role
    end
  end
end
