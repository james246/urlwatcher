URLWatcher
==========

Watch a URL for the presence or absence of some markup. An email notification is sent upon detection, using supplied mail server credentials.

Usage
-----

```
config = {
  url: 'https://github.com/james246/urlwatcher',
  interval: 60, # seconds
  notification_recipient_email: james@supercoolemail.com,
  mail: {
    address: "<Address>", # smtp.supercoolemail.com
    port: "<Port>", # 587
    domain: "<Domain>", # supercoolemail.com
    user_name: "<Username>", # james246@supercoolemail.com
    password: "<Password>" # mySup3rSecr3tPassw0rd
  }
}

w = URLWatcher::Watcher.new(config) do |document|
  # document is a Nokogiri::HTML object. Query it and return true or false from this block.

  document.css('.the-div-i-am-seeking').length > 0
end

w.start
```

A notification email will be sent the first time the supplied Nokogiri query is satisfied, at which time the program will terminate.