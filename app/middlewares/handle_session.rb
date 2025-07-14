class HandleSession
  def initialize(app)
    @app = app
  end

  def call(env)
    result = @app.call(env)

    return result unless env['rack.session'] && env['rack.session']['session_id']

    session_id_object = Rack::Session::SessionId.new(env['rack.session']['session_id'])

    session_record = ActiveRecord::SessionStore::Session.find_by_session_id(session_id_object.private_id)

    return result if session_record.blank?

    request = ActionDispatch::Request.new(env)

    session_record.update_columns(
      user_id: Current.auth&.user&.id,
      ip_address: request.remote_ip,
      user_agent: request.user_agent
    )

    result
  end
end
