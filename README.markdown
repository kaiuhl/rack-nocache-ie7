# Rack::Nocache (Only for IE7)

It deletes IE7's `ETags`, it ignores IE7's `If-*` headers, to tramples all over IE7's caching headers with:

      {
        "Cache-Control" => "no-cache, no-store, max-age=0, must-revalidate",
        "Pragma" => "no-cache",
        "Expires" => "Fri, 29 Aug 1997 02:14:00 EST"
      }

It's an abusive, grumpy, bandwidth wasting, low down dirty dog of a middleware.

But I'm sure you'll fine some use for it in development mode.

      $ gem install rack-nocache

      require "rack-nocache" # or "rack/nocache", whatever floats your boat.
      use Rack::Nocache

