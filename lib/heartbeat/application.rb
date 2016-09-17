module Heartbeat
  class Application
    def self.call(env)
      reqpath = env['PATH_INFO']
      default_headers = { 'Content-Type' => 'text/plain' }
      
      body, status =
        if reqpath =~ /200/
          ['Success!', 200]
        else
          ['Failure!', 500]
        end
      
      [status, default_headers, ["#{reqpath} == #{body}"]]
    end
  end
end

