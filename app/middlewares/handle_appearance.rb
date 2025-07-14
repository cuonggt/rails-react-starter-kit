class HandleAppearance
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    @appearance = request.cookies['appearance'] || 'system'

    @app.call(env)
  end
end
