class CollectorController < ApplicationController
  skip_before_action :verify_authenticity_token

  def pageview
    user_session = Session.find_by(session_id: session.id)

    user_session ||= Session.create({
      session_id: session.id,
      domain: URI(params[:url]).host,
      referer: params[:referer],
      ip: request.remote_ip,
    })

    user_session.page_views.create({
      url: params[:url],
      referer: params[:referer],
    })

    render text: "OK"
  end

  def script
    render layout: false
  end
end
