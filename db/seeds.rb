puts "Generating API Messages"

ApiMessage.create_or_update(:code => "200", :status => "Ok")
ApiMessage.create_or_update(:code => "201", :status => "Created")
ApiMessage.create_or_update(:code => "401", :status => "Unauthorized")
ApiMessage.create_or_update(:code => "403", :status => "Forbidden")
ApiMessage.create_or_update(:code => "404", :status => "Not found")
ApiMessage.create_or_update(:code => "422", :status => "Unprocessable Entity")
ApiMessage.create_or_update(:code => "400", :status => "Bad Request")
ApiMessage.create_or_update(:code => "405", :status => "Method Not Allowed")
ApiMessage.create_or_update(:code => "500", :status => "Internal Server Error")

puts "Generated  API Messages"

puts "Generating Default apps"

App.create_or_update(:name => "droolit", :is_default => true)

puts "Generated Default apps"