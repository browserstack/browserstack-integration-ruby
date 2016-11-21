module Selenium
  module WebDriver
    class << self
      alias_method :original_for, :for

      def for(*args)
        browser = args.shift
        opts = args.shift || {}
        opts[:url] = opts[:url] || 'http://127.0.0.1:4444/wd/hub'
        opts[:desired_capabilities] = opts[:desired_capabilities] || {}

        opts[:desired_capabilities][:browserName] = ENV['BSTACK_BROWSER'] || browser
        opts[:desired_capabilities][:browser_version] = ENV['BSTACK_BROWSER_VERSION']
        opts[:desired_capabilities][:os] = ENV['BSTACK_OS']
        opts[:desired_capabilities][:os_version] = ENV['BSTACK_OS_VERSION']
        opts[:desired_capabilities][:device] = ENV['BSTACK_DEVICE']

        if ENV['RUN_ON_BSTACK'] && ENV['RUN_ON_BSTACK'].match(/true/i)
          opts[:url] = "https://#{$browserstack_username}:#{$browserstack_access_key}@hub.browserstack.com/wd/hub"

          opts[:desired_capabilities]['browserstack.framework'] = BrowserStack::get_framework
          opts[:desired_capabilities]['browserstack.framework_version'] = BrowserStack::get_framework_version
          opts[:desired_capabilities]['build'] = ENV['BSTACK_BUILD'] if ENV['BSTACK_BUILD']
          opts[:desired_capabilities]['project'] = ENV['BSTACK_PROJECT'] if ENV['BSTACK_PROJECT']
          opts[:desired_capabilities]['name'] = ENV['BSTACK_NAME'] if ENV['BSTACK_NAME']
          if ENV['BSTACK_LOCAL'] && ENV['BSTACK_LOCAL'].match(/true/i)
            BrowserStack.start_local
            opts[:desired_capabilities]['browserstack.local'] = true
            opts[:desired_capabilities]['browserstack.localIdentifier'] = BrowserStack::get_identifier
          end
          BrowserStack::track_environment(opts[:desired_capabilities])
        end

        original_for(:remote, opts, *args)
      end
    end
  end
end
