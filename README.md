# Quanto::Ruby

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'quanto-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quanto-ruby

## Documentation

This gem is a simple OAuth client for Quanto.
Most of the logic is handled by the underlying OAuth2 library, so this gem is simply a wrapper around authenticated API calls.

To get started, you can create a client like this:

```ruby
  client = Quanto::Client.new(ENV['QUANTO_KEY'], ENV['QUANTO_SECRET'], access_token: 'my token')
```

where `'my_token'` should be your actual access token. Once you have a `Client`, you have access to the following methods:

- `#record_entry(value, metric_name, options={})`

    This method records an entry for the given metric in Quanto.
    The optional third argument lets the user specify a date, but the default is today.
    For instance, the following call would record 20 steps for today:

    ```ruby
    client.record_entry(20, :steps)
    ```

    while this call would record 137 pushups for April 1st 2013.

    ```ruby
    client.record_entry(137, :pushups, date: '2013-04-01')
    ```

- `#plugin_url`

    Returns the URL of this plugin on Quanto.
    Useful when redirecting the user after authenticating.

- `#activate_plugin`

    Activates the plugin in Quanto.
    This should be called whenever the plugin has successfully obtained all 3rd party credentials and is ready to send data.

- `#metrics`

    Returns a list of metrics enabled for the current plugin of the following format:

    ```ruby
    [{
      'name' => 'steps',
      'metric_type' => 'count',
    },
    {
      'name' => 'sleep',
      'metric_type' => 'minutes',
    }]
    ```
