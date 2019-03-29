# web server for ccglab
# -cem bozsahin March 2019
import http.server
import socketserver

HTTPS = 443
PORT = HTTPS # only https for security freaks at uni's computer center

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("serving at port", PORT)
    httpd.serve_forever()
