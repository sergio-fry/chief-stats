class CollectorController < ApplicationController
  def pageview
    PageView.create({
      url: params[:url],
      referer: params[:referer],
    })

    render text: "OK"
  end
end
