module Quanto

  class Client

    def record_entry(value, metric_name, opts={})
      entry  = {
        metric: metric_name,
        value: value,
        date: opts[:date] || Time.zone.now.to_date.to_s
      }
      post('/entries', entry: entry)
    end

    # Make a GET request for the URL for the authenticated plugin.
    # Returns the plugin URL as a string.
    def plugin_url
      attributes = get('/plugin')
      attributes["url"]
    end

    # Activate the current plugin.
    # This should only be done once credentials have been obtained.
    # Returns the url for the current plugin.
    def activate_plugin
      attributes = post('/activations')
      attributes["url"]
    end

    def metrics
      get('/plugin/metrics')
    end

  end

end
