require 'mail'

class Notifier
  def initialize(recipient_email, url, config)
    @recipient_email = recipient_email
    @config = config
    @url = url
    
    Mail.defaults do
      delivery_method :smtp, {
        address:              config['address'],
        port:                 config['port'],
        domain:               config['domain'],
        user_name:            config['user_name'],
        password:             config['password'],
        authentication:       'plain',
        enable_starttls_auto: true
      }
    end
  end

  def deliver_success_notification!(from, to, message)
    Mail.deliver do
      from    from
      to      to
      subject message
      body    message
    end
  end
end