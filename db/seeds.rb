# admin and non-admin users
unless User.exists?(email: 'admin@ticketee.com')
  User.create!(email: 'admin@ticketee.com', password: 'password', admin: true)
end

unless User.exists?(email: 'viewer@ticketee.com')
  User.create!(email: 'viewer@ticketee.com', password: 'password')
end

# sample projects
['Sublime Text 3', 'Internet Explorer'].each do |name|
  unless Project.exists?(name: name)
    Project.create!(name: name, description: "A sample project about #{ name }")
  end
end