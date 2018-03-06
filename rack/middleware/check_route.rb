class CheckRoute
  def initialize(app)
    @app = app
  end
  def call(env)
    path = env["REQUEST_PATH"]
    unless path == "/time"
      [404, {'Content-Type' => "text/html"}, ["Not Found\n"]]
    else
      status, headers, body = @app.call(env)
    end
  end

end
