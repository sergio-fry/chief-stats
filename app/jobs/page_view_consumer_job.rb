class PageViewConsumerJob < ActiveJob::Base
  queue_as :pageview

  def perform(client_id, session_id, ip, user_agent, url, referer)
    ActiveRecord::Base.transaction do
      @client = Client.find_or_create_by(cookie_id: client_id)
      @user_session = @client.sessions.find_by(session_id: session_id)

      @user_session ||= @client.sessions.create({
        session_id: session_id,
        ip: ip,
        user_agent: user_agent,
        referer: referer,
      })

      @user_session.page_views.create({
        url: url,
        referer: referer,
      })
    end
  end
end
