require 'socket'
require 'json'
 
host = 'localhost'     # The web server
port = 2000                           # Default HTTP port
params = Hash.new {|hash, key| hash[key] = Hash.new}

method = ''
until method == 'GET' || method == 'POST'
  print "Method for request, GET or POST? "
  method = gets.chomp.upcase
end

if method == 'POST'
  print "Enter Name: "
  name = gets.chomp
  print "Enter email: "
  email = gets.chomp
  params[:person][:name] = name
  params[:person][:email] = email
  body = params.to_json
  request = "#{method} /thanks.html HTTP/1.0\r\n
            Content-Length: #{params.to_json.length}\r\n\r\n
            #{body}"
else
  request = "#{method} /index.html HTTP/1.0\r\n\r\n"
end

socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
response = socket.read              # Read complete response
# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
puts ''
print body                          # And display it
socket.close
