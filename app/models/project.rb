class Project < ActiveRecord::Base
  validates :name, presence: true

  # `:destroy` will go through tickets one by one and delete them when the project is
  # deleted. This can be slow so there is `:delete_all` which will delete all 
  # tickets at once and ignore all callbacks.
  has_many :tickets, dependent: destroy
end
