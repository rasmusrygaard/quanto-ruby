module Quanto

  class Client

    def record_metric(value, type)
      post('/metrics', { value: value, type: type })
    end

  end

end
