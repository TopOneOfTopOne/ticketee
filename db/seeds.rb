unless User.exists?(email: "admin@ticketee.com")
  User.create!(email: "admin@ticketee.com", password: "password", admin: true)
end

unless User.exists?(email: "viewer@ticketee.com")
  User.create!(email: "viewer@ticketee.com", password: "password")
end

%w(Facebook Google Amazon).each do |project|
  unless Project.exists?(name: project)
    Project.create!(name: project, description: "The creation of #{project}")
  end
end
