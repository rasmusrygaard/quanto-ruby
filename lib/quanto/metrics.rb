module Quanto

  class Client

    def record_metric(value, type, opts={})
      metric  = {
        metric_type: type,
        value: value,
        date: opts[:date] || Date.today.to_s
      }
      post('/metrics', metric: metric)
    end

    # Make a GET request for the URL for the authenticated plugin.
    # Returns the plugin URL as a string.
    def plugin_url
      attributes = get('/plugin')
      attributes["url"]
    end

  end

end
