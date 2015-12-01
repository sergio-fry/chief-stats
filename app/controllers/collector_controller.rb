class CollectorController < ApplicationController
  skip_before_action :verify_authenticity_token

  def pageview
    PageView.create({
      url: params[:url],
      referer: params[:referer],
    })

    render text: "OK"
  end

  def script
    render layout: false
  end
end
