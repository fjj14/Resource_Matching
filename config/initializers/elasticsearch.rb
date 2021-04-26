if Rails.env == 'production'
    url = ENV["BONSAI_URL"]
    transport_options = { request: { timeout: 250 } }
    options = { hosts: url, retry_on_failure: true, transport_options: transport_options }
    Searchkick.client = Elasticsearch::Client.new(options)
end
if Rails.env == 'development'
  Searchkick.client = Elasticsearch::Client.new(hosts: ["localhost:3000"], retry_on_failure: true, transport_options: {request: {timeout: 250}})
end