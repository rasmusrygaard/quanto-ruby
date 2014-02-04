module Quanto

  class Client

    def record_entry(value, metric_name, opts={})
      entry  = {
        metric: metric_name,
        value: value,
        date: opts[:date] || Date.today.to_s
      }
      post('/entries', entry: entry)
    end

    # Make a GET request for the URL for the authenticated plugin.
    # Returns the plugin URL as a string.
    def plugin_url
      attributes = get('/plugin')
      attributes["url"]
    end

  end

end
