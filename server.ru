$eventmachine_library = :pure_ruby
require 'em/pure_ruby'
puts EM.library_type
class Runtime
  def initialize(app, name = nil)
    @app = app
    @header_name = "X-Runtime"
    @header_name << "-#{name}" if name
  end

  def call(env)
    r = Rack::Request.new(env)
    puts r.url
    status, headers, body = @app.call(env)
    [status, headers, body]
  end
end

file = File.read('index.html')
app = proc do |env|
  r = Rack::Request.new(env)

  if r.path == '/'
    tmpl = file
    content_type = 'text/html'
  else
    sleep 1
    content_type = 'application/json'
    tmpl = '{"hello":"world"}'
  end

  [
    200,
    {
      'Content-Type' => content_type,
      'Content-Length' => tmpl.size.to_s,
    },
    [tmpl]
  ]
end

# You can install Rack middlewares
# to do some crazy stuff like logging,
# filtering, auth or build your own.
use Runtime
use Rack::CommonLogger
run app