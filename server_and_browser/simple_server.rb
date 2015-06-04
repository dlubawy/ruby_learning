require 'socket'               # Get sockets from stdlib
require 'json'

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
  request = client.read_nonblock(256)
  request_head, request_body = request.split("\r\n\r\n", 2)
  path = request_head.split[1][1..-1]
  method = request_head.split[0]

  if File.exist?(path)
    response = File.read(path)
    client.print "HTTP/1.1 200 OK\r\n\r\n"
    if method == "GET"
      client.puts response
    elsif method == "POST"
      params = JSON.parse(request_body)
      hash_data = "<li>name: #{params['person']['name']}</li>
                  <li>email: #{params['person']['email']}</li>"
      client.puts response.gsub('<%= yield %>', hash_data)
    end
  else
    client.puts "HTTP/1.1 404 Not Found\r\n\r\n"
    client.puts "404 Error, File not Found"
  end
  client.close                 # Disconnect from the client
}
