URLWatcher
==========

Watch a URL for the presence or absence of some markup. An email notification is sent upon detection, using supplied mail server credentials.

Usage example
-------------

Using URLWatcher in conjunction with the [Daemons gem](https://github.com/thuehlinger/daemons):

```
require 'urlwatcher'
require 'daemons'

config = {
  url: 'https://github.com/james246/urlwatcher',

  # interval at which to scrape url, in seconds
  interval: 60, 
  
  notification_recipient_email: james@supercoolemail.com,
  
  mail: {
    # e.g. smtp.supercoolemail.com
    address: "<Address>", 

    # e.g. 587
    port: "<Port>", 

    # e.g. supercoolemail.com
    domain: "<Domain>", 

    # e.g. james246@supercoolemail.com
    user_name: "<Username>", 

    # e.g. mySup3rSecr3tPassw0rd
    password: "<Password>" 
  }
}

# The `document` variable passed into the block is a Nokogiri::HTML object. Use selectors on it
# to find the markup you're looking for and return true or false depending on whether you find
# it or not. The first time the block returns true, an email notification will be sent and
# the program will terminate.
w = URLWatcher::Watcher.new(config) do |document|
  document.css('.the-div-i-am-seeking').length > 0
end

Daemons.daemonize({
  :app_name => 'myURLWatcher',

  # set logging options to capture STDOUT from URLWatcher if you wish
  log_output: true, 
  dir_mode: :normal,
  dir: File.expand_path(File.dirname(__FILE__))
})

w.start
```