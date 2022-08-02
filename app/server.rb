require 'net/http/server'
require 'pp'
require 'cgi'
require 'ostruct'

class Server 
    def method_missing(name, *args, **vargs) 
        self.call(name)
    end

end

Net::HTTP::Server.run(:port => 8080) do |request, stream|
    request = OpenStruct.new(request)
    request.tap do 
        request[:uri][:query] = OpenStruct.new(
            CGI::parse(request[:uri][:query].to_s)
        )
    #   pp request[:uri][:query].class
    end

  pp request

  [200, {'Content-Type' => 'text/html'}, ['Hello World']]
end