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

  end

end
