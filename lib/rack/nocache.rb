module Rack
  class Nocache
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(patch_request_headers(env))
      [status, patch_response_headers(headers, env), body]
    end

  protected
    CACHE_BUSTER = {
      "Cache-Control" => "no-cache, no-store, max-age=0, must-revalidate, post-check=0, pre-check=0",
      "Pragma" => "no-cache",
      "Expires" => "Fri, 29 Aug 1997 02:14:00 EST"
    }

    def ie?(env)
      env["HTTP_USER_AGENT"].to_s.include? "MSIE 7"
    end

    def patch_request_headers(env)
      env.reject! { |k,v| k =~ /^HTTP_IF/i } if ie?(env)
      env
    end

    def patch_response_headers(headers, env)
      if ie?(env)
        headers.reject! { |k,v| k =~ /^ETag$/i }
        headers ||= {}
        headers.merge!(CACHE_BUSTER)
      end
      headers
    end
  end
end

