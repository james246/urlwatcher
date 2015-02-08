require 'logger'

require_relative 'urlwatcher/page'
require_relative 'urlwatcher/notifier'

class URLWatcher
  def initialize(config, &matcher)
    @config   = config
    @interval = @config['interval']

    @matcher  = matcher
    @page     = Page.new(@config['url'])
    @logger   = Logger.new(File.new('urlwatcher.log', 'a+'))
    @notifier = Notifier.new(@config['notification_recipient_email'], @config['url'], @config['mail'])
  end

  def start
    loop do
      if @done
        @logger.info 'Terminating...'
        break 
      end

      check
      sleep @interval
    end
  end

  def check
    @logger.info('Checking...')
    if matches?
      @logger.info('Found a match')
      notify!
    end
  end

  def matches?
    @matcher.call(@page.document)
  end

  def notify!
    from = @config['mail']['user_name']
    to   = @config['notification_recipient_email']
    
    @logger.info("Sending notification to #{to} from #{from}")

    @notifier.deliver_success_notification!(from, to, "Match found on: #{@page.url}")
    @done = true
  end
end