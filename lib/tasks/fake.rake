namespace :fake do
  task :do => :environment do
    while PageView.count < 50000


      step = 1.hour + rand(2.weeks).seconds
      start = rand(1.month).seconds.ago

      current = start
      
      client = Client.create(cookie_id: rand, created_at: current)

      while current.past?
        user_session = client.sessions.create({
          session_id: rand,
          referer: rand > 0.9 ? "http://example.com/page-#{rand(999)}" : nil,
          ip: (1..4).map{ rand(255) }.join("."),
          user_agent: "Firefox (Ubuntu) ver 2.13",
          created_at: current,
        })

        (1 + rand(10)).times do |n|
          user_session.page_views.create({
            url: "http://example.com/page-#{rand(999)}",
            referer: "http://example.com/page-#{rand(999)}",
            created_at: current + n.minutes,
          })
        end


        current += step
      end


      print "."
    end

    puts "PageViews: #{PageView.count}"
  end
end
