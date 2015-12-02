class CollectorController < ApplicationController
  skip_before_action :verify_authenticity_token
  around_filter :transaction_wrapper, only: :pageview

  def pageview
    # client_id - идентификатор клиента
    cookies[:client_id] ||= { value: Digest::SHA256.hexdigest("#{Time.now.to_f}#{rand}"), expire: 3.years.from_now }
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

  private

  def transaction_wrapper
    ActiveRecord::Base.transaction do
      yield
    end
  end
end
