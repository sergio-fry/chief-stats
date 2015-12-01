class CollectorController < ApplicationController
  skip_before_action :verify_authenticity_token

  def pageview
    # client_id - идентификатор клиента
    # назначается по первой сессии на сайте
    cookies[:client_id] ||= { value: session.id, expire: 3.years.from_now }
    @client = Client.find_or_create_by(cookie_id: cookies[:client_id])

    @user_session = @client.sessions.find_by(session_id: session.id)

    @user_session ||= @client.sessions.create({
      session_id: session.id,
      domain: URI(params[:url]).host,
      referer: params[:referer],
      ip: headers["CF-Connecting-IP"] || request.remote_ip,
      user_agent: request.user_agent,
    })

    @user_session.page_views.create({
      url: params[:url],
      referer: params[:referer],
    })

    render text: "OK"
  end

  def script
    render layout: false
  end
end
