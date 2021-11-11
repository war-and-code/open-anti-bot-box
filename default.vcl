vcl 4.0;

# This will point to Apache content server
backend default {
    .host = "127.0.0.1";
    .port = "8080";
}

# Happens before we check if we have this in cache already.
# Typically you clean up the request here, removing cookies you don't need,
# rewriting the request, etc.
sub vcl_recv {
}

# Happens after we have read the response headers from the backend.
# Here you clean the response headers, removing silly Set-Cookie headers
# and other mistakes your backend does.
sub vcl_backend_response {
}

# Happens when we have all the pieces we need, and are about to send the
# response to the client.
# You can do accounting or modifying the final object here.
sub vcl_deliver {
    # Never send an actual 406 from our WAF back to the client
    if (resp.status == 406) {
        set resp.status = 401;
        set resp.response = "Unauthorized (spoof!)";
    }
}