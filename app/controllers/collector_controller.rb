class CollectorController < ApplicationController
  skip_before_action :verify_authenticity_token
  around_filter :transaction_wrapper, only: :pageview

  def pageview
    # TODO: вынести в bg job
    # https://github.com/brandonhilkert/sucker_punch
    # ConsumePageViewJob.perform_later(client_id, session_id, ip, user_agent, url, referer)


    # client_id - идентификатор клиента
    cookies[:client_id] ||= { value: Digest::SHA256.hexdigest("#{Time.now.to_f}#{rand}"), expires: 3.years.from_now }
    @client = Client.find_or_create_by(cookie_id: cookies[:client_id])

    cookies[:session_id] ||= { value: Digest::SHA256.hexdigest("#{Time.now.to_f}#{rand}"), expires: 30.minutes.from_now }
    @user_session = @client.sessions.find_by(session_id: cookies[:session_id])

    @user_session ||= @client.sessions.create({
      session_id: cookies[:session_id],
      referer: params[:referer],
      ip: headers["CF-Connecting-IP"] || request.remote_ip,
      user_agent: request.user_agent,
    })

    @user_session.page_views.create({
      url: params[:url],
      referer: params[:referer],
    })

=begin
    response.headers.delete "X-Frame-Options"
    response.headers["Content-Security-Policy"] = "frame-ancestors *"
    response.headers["Access-Control-Allow-Credentials"] = "true"
    response.headers["Access-Control-Allow-Origin"] = "#{URI(request.referer).scheme}://#{URI(request.referer).host}" rescue nil
=end

    render text: "OK"
  end

  def script
    render layout: false
  end

  private

  def transaction_wrapper
    ActiveRecord::Base.transaction do
      yield
    end
  end
end
